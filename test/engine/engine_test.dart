import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/engine.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/misc/list_extensions.dart';
import 'package:wildwest_flutter/engine/rules/rules.dart';
import 'package:wildwest_flutter/engine/setup/loader.dart';
import 'package:wildwest_flutter/engine/setup/setup.dart';
import 'package:wildwest_flutter/engine/state/state.dart';
import 'package:wildwest_flutter/pages/game/cubit/game_cubit.dart';

void main() {
  late GEngine sut;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
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
    sut = GEngine(state: state, rules: rules);
  });

  test('emit active moves if refresh', () async {
    // Given
    GEvent? lastEvent;
    sut.eventSubject.listen((event) {
      print(event);
      lastEvent = event;
    });

    // When
    await sut.refresh();
    await Future.delayed(const Duration(seconds: 1), () {});

    // Assert
    expect(lastEvent is GEventActivate, isTrue);
  });

  test('game should complete', () async {
    // Given
    sut.eventSubject.listen((event) {
      print(event);
      if (event is GEventActivate) {
        final best = event.moves.randomElement();
        sut.play(best);
      }
    });

    // When
    // Assert
    await sut.refresh();
    while (sut.stateSubject.value.winner == null) {
      await Future.delayed(const Duration(seconds: 1), () {});
    }
  });
}
