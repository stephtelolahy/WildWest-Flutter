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

  test('can play bang if other is reachable', () {
    // Given
    final card1 = GCard(id: 'c1', abilities: ['bang'], type: CardType.brown);
    final player1 = GPlayer(id: 'p1', hand: [card1]);
    final player2 = GPlayer(id: 'p2');
    final player3 = GPlayer(id: 'p3', mustang: 2);
    final state = GState(
        players: [player1, player2, player3], playOrder: ['p1', 'p2', 'p3'], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, equals([GMove(ability: 'bang', actor: 'p1', handCard: 'c1', target: 'p2')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventSetHit(
              hit: GHit(name: 'bang', players: ['p2'], abilities: ['looseHealth', 'cancelShoot'])),
        ]));
  });

  test('cannot play bang if reached limit per turn', () {
    // Given
    final card1 = GCard(id: 'c1', abilities: ['bang'], type: CardType.brown);
    final player1 = GPlayer(id: 'p1', hand: [card1]);
    final player2 = GPlayer(id: 'p2');
    final state = GState(
      players: [player1, player2],
      playOrder: ['p1', 'p2'],
      turn: 'p1',
      phase: 2,
      played: ['bang'],
    );

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, isEmpty);
  });
}
