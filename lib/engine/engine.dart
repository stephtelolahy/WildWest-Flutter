import 'dart:collection';

import 'package:rxdart/subjects.dart';

import 'event/event.dart';
import 'rules/rules.dart';
import 'state/state.dart';

class GEngine {
  final PublishSubject<GEvent> eventSubject;
  final BehaviorSubject<GState> stateSubject;

  final Queue<GEvent> _queue;
  final GRules _rules;

  GEngine(GState initialState, GRules rules)
      : this.eventSubject = PublishSubject<GEvent>(),
        this.stateSubject = BehaviorSubject<GState>.seeded(initialState),
        this._queue = Queue(),
        this._rules = rules;

  Future<void> dispatch(GMove move) async {
    if (_queue.isNotEmpty) {
      print("engine busy");
      return;
    }

    _queue.addLast(GEventMove(move: move));
    await _update();
    _emitActiveMoves();
  }

  Future<void> _update() async {
    final state = stateSubject.value;

    if (state.winner != null) {
      return;
    }

    final winner = _rules.isGameOver(state);
    if (winner != null) {
      await _dispatch(GEventGameOver(winner: winner), state);
      await _update();
      return;
    }

    if (_queue.isEmpty) {
      _queueTriggers(GEventEmptyQueue(), state);
      if (_queue.isNotEmpty) {
        await _update();
      }
      return;
    }

    final event = _queue.removeFirst();
    await _dispatch(event, state);
    _queueTriggers(event, state);
    _queueEffects(event, state);
    await _update();
  }

  Future<void> _dispatch(GEvent event, GState state) async {
    eventSubject.add(event);
    await new Future.delayed(event.duration());
    stateSubject.add(event.dispatch(state));
  }

  void _queueEffects(GEvent event, GState state) {
    if (event is GEventMove) {
      final effects = _rules.effects(event.move, state);
      effects.reversed.forEach((e) {
        _queue.addFirst(e);
      });
    }
  }

  void _queueTriggers(GEvent event, GState state) {
    final moves = _rules.triggered(event, state);
    moves.forEach((e) {
      _queue.addLast(GEventMove(move: e));
    });
  }

  void _emitActiveMoves() {
    final state = stateSubject.value;
    if (state.winner == null) {
      final moves = _rules.active(state);
      eventSubject.add(GEventActivate(moves: moves));
    }
  }
}
