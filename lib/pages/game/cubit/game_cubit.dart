import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wildwest_flutter/engine/misc/list_extensions.dart';

import '../../../engine/engine.dart';
import '../../../engine/event/event.dart';
import '../../../engine/rules/rules.dart';
import '../../../engine/setup/loader.dart';
import '../../../engine/setup/setup.dart';
import '../../../engine/state/state.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameStateLoading());

  late GEngine engine;

  Future<void> load() async {
    final loader = ResLoader();
    final abilities = await loader.loadAbilities();
    final cards = await loader.loadCards();
    final cardValues = await loader.loadCardValues();
    final rules = GRules(abilities: abilities);
    final setup = GSetup();
    final roles = setup.roles(playersCount: 5);
    final deck = setup.deck(cards: cards, values: cardValues);
    final figures = cards.where((e) => e.type == CardType.figure).toList();
    final defaults = cards.where((e) => e.type == CardType.none).toList();
    final state = setup.game(roles: roles, figures: figures, defaults: defaults, deck: deck);
    engine = GEngine(state: state, rules: rules, maxEventDurationMillis: 400);

    engine.stateSubject.listen((gSate) {
      final you = gSate.players.first;
      final others = gSate.players.sublist(1, gSate.players.length);
      final discard = gSate.discard.isNotEmpty ? gSate.discard.last : null;
      emit(GameStateLoaded(others: others, you: you, discard: discard));
    });
  }

  Future<void> loop() async {
    engine.eventSubject.listen((event) {
      print(event);
      if (event is GEventActivate) {
        final best = event.moves.randomElement();
        engine.play(best);
      }
    });

    await engine.refresh();
  }

/*
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
      discard: state.discard,
      hand: hand,
      event: event,
    ));

    Future.delayed(event.duration, () {
      emit(GameState(
          others: state.others, discard: state.discard + [card], hand: state.hand, event: null));
    });
  }

  void drawDeck() {
    final event = GameEventDrawDeck(card: _pullDeck());
    emit(
      GameState(others: state.others, discard: state.discard, hand: state.hand, event: event),
    );

    Future.delayed(
      event.duration,
      () => emit(GameState(
          others: state.others,
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
      GameState(others: state.others, discard: state.discard, hand: hand, event: event),
    );

    Future.delayed(
      event.duration,
      () => emit(GameState(
          others: state.others,
          discard: state.discard + [event.card],
          hand: state.hand,
          event: null)),
    );
  }
  */
}
