import 'dart:collection';

import 'package:rxdart/subjects.dart';

import 'event/event.dart';
import 'rules/rules.dart';
import 'state/state.dart';

class GEngine {
  final PublishSubject<GEvent> eventSubject;
  final BehaviorSubject<GState> stateSubject;

  final GRules _rules;
  final Queue<GEvent> _queue;

  GEngine({required GState initialState, required GRules rules})
      : this.eventSubject = PublishSubject<GEvent>(),
        this.stateSubject = BehaviorSubject<GState>.seeded(initialState),
        this._rules = rules,
        this._queue = Queue();

  Future<void> dispatch(GMove move) async {
    if (_queue.isNotEmpty) {
      print("engine busy");
      return;
    }

    _queue.addLast(GEventPlay(move: move));
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
      await _dispatch(GEventSetWinner(winner: winner), state);
      await _update();
      return;
    }

    if (_queue.isEmpty) {
      _queueTriggers(GEventIdle(), state);
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
    if (event is GEventPlay) {
      final effects = _rules.effects(event.move, state);
      effects.reversed.forEach((e) {
        _queue.addFirst(e);
      });
    }
  }

  void _queueTriggers(GEvent event, GState state) {
    final moves = _rules.triggered(event, state);
    moves.forEach((e) {
      _queue.addLast(GEventPlay(move: e));
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
