import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit()
      : super(GameState(
            others: List.generate(6, (index) => 'player $index'),
            played: null,
            discard: [],
            hand: [],
            event: null));

  int _counter = 0;
  String _pullDeck() {
    _counter++;
    return "card $_counter";
  }

  void play({required String card, required Offset center}) {
    final hand = state.hand..remove(card);
    final event = GameEventPlay(card: card, center: center);
    emit(GameState(
      others: state.others,
      played: state.played,
      discard: state.discard,
      hand: hand,
      event: event,
    ));

    Future.delayed(event.duration, () {
      final discard = state.discard;
      final played = state.played;
      if (played != null) {
        discard.add(played);
      }

      emit(GameState(
          others: state.others,
          played: event.card,
          discard: discard,
          hand: state.hand,
          event: null));
    });
  }

  void drawDeck() {
    final event = GameEventDrawDeck(card: _pullDeck());
    emit(
      GameState(
          others: state.others,
          played: state.played,
          discard: state.discard,
          hand: state.hand,
          event: event),
    );

    Future.delayed(
      event.duration,
      () => emit(GameState(
          others: state.others,
          played: state.played,
          discard: state.discard,
          hand: state.hand + [event.card],
          event: null)),
    );
  }

  void discardHand() {
    final card = state.hand.first;
    final event = GameEventDiscardHand(card: card);

    final hand = state.hand;
    hand.remove(card);

    emit(
      GameState(
          others: state.others,
          played: state.played,
          discard: state.discard,
          hand: hand,
          event: event),
    );

    Future.delayed(
      event.duration,
      () => emit(GameState(
          others: state.others,
          played: state.played,
          discard: state.discard + [event.card],
          hand: state.hand,
          event: null)),
    );
  }
}
