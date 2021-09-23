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

  test('can play gatling if having card', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['gatling'], type: CardType.brown);
    final player1 = GPlayer(identifier: 'p1', hand: [card1]);
    final player2 = GPlayer(identifier: 'p2');
    final player3 = GPlayer(identifier: 'p3');
    final state = GState(
        players: [player1, player2, player3], playOrder: ['p2', 'p3', 'p1'], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, equals([GMove(ability: 'gatling', actor: 'p1', handCard: 'c1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventSetHit(
              hit: GHit(
                  name: 'gatling',
                  players: ['p2', 'p3'],
                  abilities: ['looseHealth', 'cancelShoot'])),
        ]));
  });
}
