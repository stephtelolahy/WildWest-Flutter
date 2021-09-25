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

  test('can play indians if having card', () {
    // Given
    final card1 = GCard(id: 'c1', abilities: ['indians'], type: CardType.brown);
    final player1 = GPlayer(id: 'p1', hand: [card1]);
    final player2 = GPlayer(id: 'p2');
    final player3 = GPlayer(id: 'p3');
    final state = GState(
        players: [player1, player2, player3], playOrder: ['p3', 'p1', 'p2'], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, equals([GMove(ability: 'indians', actor: 'p1', handCard: 'c1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventSetHit(
              hit: GHit(name: 'indians', players: ['p2', 'p3'], abilities: ['looseHealth'])),
        ]));
  });
}
