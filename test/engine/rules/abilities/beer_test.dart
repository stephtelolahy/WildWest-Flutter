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

  test('can play beer if damaged', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['beer'], type: CardType.brown);
    final player1 = GPlayer(identifier: 'p1', bullets: 4, health: 3, hand: [card1]);
    final state = GState(players: [player1], turn: 'p1', phase: 2, playOrder: ['p1', 'p2', 'p3']);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, equals([GMove(ability: 'beer', actor: 'p1', handCard: 'c1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventGainHealth(player: 'p1'),
        ]));
  });

  test('cannot play beer if max health', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['beer'], type: CardType.brown);
    final player1 = GPlayer(identifier: 'p1', bullets: 4, health: 4, hand: [card1]);
    final state = GState(players: [player1], turn: 'p1', phase: 2, playOrder: ['p1', 'p2', 'p3']);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, isEmpty);
  });

  test('cannot play beer if two players left', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['beer'], type: CardType.brown);
    final player1 = GPlayer(identifier: 'p1', bullets: 4, health: 3, hand: [card1]);
    final state = GState(players: [player1], turn: 'p1', phase: 2, playOrder: ['p1', 'p2']);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, isEmpty);
  });
}
