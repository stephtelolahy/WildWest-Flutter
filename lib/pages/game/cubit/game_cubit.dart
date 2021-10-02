import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../engine/engine.dart';
import '../../../engine/event/event.dart';
import '../../../engine/misc/list_extensions.dart';
import '../../../engine/rules/rules.dart';
import '../../../engine/setup/loader.dart';
import '../../../engine/setup/setup.dart';
import '../../../engine/state/state.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState?> {
  GameCubit() : super(null);

  late GEngine engine;
  late GState lastState;

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
    final initialState = setup.game(roles: roles, figures: figures, defaults: defaults, deck: deck);
    engine = GEngine(state: initialState, rules: rules, eventDurationMillis: 400);

    emit(createState(initialState, null));

    engine.stateSubject.listen((state) {
      lastState = state;
    });
  }

  Future<void> loop() async {
    engine.eventSubject.listen((event) {
      print(event);

      emit(createState(lastState, event));

      if (event is GEventActivate) {
        final best = event.moves.randomElement();
        engine.play(best);
      }
    });

    await engine.refresh();
  }

  static GameState createState(GState state, GEvent? event) {
    final controlledId = state.players.singleWhere((e) => e.role == Role.sheriff).id;
    final you = state.player(id: controlledId);
    final others = state.players.startingWhere((e) => e.id == controlledId).skip(1).toList();
    final discard = state.discard.isNotEmpty ? state.discard.last : null;
    return GameState(
      gState: state,
      others: others,
      you: you,
      discard: discard,
      event: event,
    );
  }
}
