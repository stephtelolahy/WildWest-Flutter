import 'dart:collection';

import 'package:rxdart/subjects.dart';

import 'event/event.dart';
import 'move/move.dart';
import 'rules/rules.dart';
import 'state/state.dart';

class GEngine {
  final PublishSubject<GEvent> eventSubject;
  final BehaviorSubject<GState> stateSubject;

  final GRules _rules;
  final Queue<GEvent> _queue;
  final int _maxEventDurationMillis;

  GEngine({required GState state, required GRules rules, int maxEventDurationMillis = 0})
      : this.eventSubject = PublishSubject<GEvent>(),
        this.stateSubject = BehaviorSubject<GState>.seeded(state),
        this._rules = rules,
        this._queue = Queue(),
        this._maxEventDurationMillis = maxEventDurationMillis;

  Future<void> play(GMove move) async {
    if (_queue.isNotEmpty) {
      throw UnsupportedError('Engine busy');
    }
    _queue.addLast(GEventPlay(move: move));
    await refresh();
  }

  Future<void> refresh() async {
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
    if (event is GEventPlay) {
      _queueEffects(event.move, state);
    }
    await _update();
  }

  Future<void> _dispatch(GEvent event, GState state) async {
    eventSubject.add(event);

    final duration = Duration(milliseconds: (event.duration() * _maxEventDurationMillis).toInt());
    await new Future.delayed(duration);

    final newState = event.dispatch(state);
    if (newState != null) {
      stateSubject.add(newState);
    }
  }

  void _queueEffects(GMove move, GState state) {
    final effects = _rules.effects(move, state);
    effects.reversed.forEach((e) {
      _queue.addFirst(e);
    });
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
