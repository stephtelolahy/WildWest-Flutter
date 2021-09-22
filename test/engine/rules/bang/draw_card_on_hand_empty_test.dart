import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/rules/rules.dart';
import 'package:wildwest_flutter/engine/setup/loader.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  late GRules sut;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final abilities = await ResLoader().loadAbilities();
    sut = GRules(abilities: abilities);
  });

  test('draw card on discard hand then hand empty', () {
    // Given
    final player1 = GPlayer(identifier: 'p1', abilities: ['drawCardOnHandEmpty']);
    final state = GState(players: [player1], playOrder: ['p1']);
    final event = GEventDiscardHand(player: 'p1', card: 'cX');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'drawCardOnHandEmpty', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(events, equals([GEventDrawDeck(player: 'p1')]));
  });

  test('draw card on equip then hand empty', () {
    // Given
    final player1 = GPlayer(identifier: 'p1', abilities: ['drawCardOnHandEmpty']);
    final state = GState(players: [player1], playOrder: ['p1']);
    final event = GEventEquip(player: 'p1', card: 'cX');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'drawCardOnHandEmpty', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(events, equals([GEventDrawDeck(player: 'p1')]));
  });

  test('draw card on handicap then hand empty', () {
    // Given
    final player1 = GPlayer(identifier: 'p1', abilities: ['drawCardOnHandEmpty']);
    final state = GState(players: [player1], playOrder: ['p1']);
    final event = GEventHandicap(player: 'p1', card: 'cX', other: 'pX');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'drawCardOnHandEmpty', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(events, equals([GEventDrawDeck(player: 'p1')]));
  });

  test('draw card on draw hand then hand empty', () {
    // Given
    final player1 = GPlayer(identifier: 'p1', abilities: ['drawCardOnHandEmpty']);
    final state = GState(players: [player1], playOrder: ['p1']);
    final event = GEventDrawHand(player: 'pX', other: 'p1', card: 'cX');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'drawCardOnHandEmpty', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(events, equals([GEventDrawDeck(player: 'p1')]));
  });
}
