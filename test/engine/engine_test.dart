import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/engine.dart';
import 'package:wildwest_flutter/engine/rules/rules.dart';
import 'package:wildwest_flutter/engine/setup/loader.dart';
import 'package:wildwest_flutter/engine/setup/setup.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('emit active moves if refresh', () async {
    // Given
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
    final sut = GEngine(initialState: initialState, rules: rules);
    sut.eventSubject.listen((event) {
      print(event);
    });
    sut.stateSubject.listen((state) {
      print(state);
    });

    // When
    await sut.refresh();

    // Assert
    expect(initialState.winner, isNull);
  });
}
