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

  test('can discard beer if is target of shoot and will be eliminated', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['discardBeer'], type: CardType.brown);
    final player1 = GPlayer(identifier: 'p1', health: 1, hand: [card1]);
    final hit = GHit(players: ['p1'], abilities: ['looseHealth']);
    final state = GState(players: [player1], hit: hit, playOrder: ['p1', 'p2', 'p3']);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, contains(GMove(ability: 'discardBeer', actor: 'p1', handCard: 'c1')));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventRemoveHit(player: 'p1'),
        ]));
  });

  test('cannot discard beer if not last health', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['discardBeer'], type: CardType.brown);
    final player1 = GPlayer(identifier: 'p1', health: 2, hand: [card1]);
    final hit = GHit(players: ['p1'], abilities: ['looseHealth']);
    final state = GState(players: [player1], hit: hit, playOrder: ['p1', 'p2', 'p3']);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves.contains(GMove(ability: 'discardBeer', actor: 'p1', handCard: 'c1')), isFalse);
  });

  test('cannot discard beer if two players left', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['discardBeer'], type: CardType.brown);
    final player1 = GPlayer(identifier: 'p1', health: 1, hand: [card1]);
    final hit = GHit(players: ['p1'], abilities: ['looseHealth']);
    final state = GState(players: [player1], hit: hit, playOrder: ['p1', 'p2']);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves.contains(GMove(ability: 'discardBeer', actor: 'p1', handCard: 'c1')), isFalse);
  });
}
