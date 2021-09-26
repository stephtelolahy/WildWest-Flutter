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

  test('can play duel againts any other player', () {
    // Given
    final card1 = GCard(id: 'c1', abilities: ['duel'], type: CardType.brown);
    final player1 = GPlayer(id: 'p1', hand: [card1]);
    final player2 = GPlayer(id: 'p2');
    final player3 = GPlayer(id: 'p3');
    final state = GState(
        players: [player1, player2, player3], playOrder: ['p1', 'p2', 'p3'], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(
        moves,
        equals([
          GMove(ability: 'duel', actor: 'p1', handCard: 'c1', args: PlayArgs(target: 'p2')),
          GMove(ability: 'duel', actor: 'p1', handCard: 'c1', args: PlayArgs(target: 'p3')),
        ]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventSetHit(
              hit:
                  GHit(name: 'duel', players: ['p2'], abilities: ['looseHealth'], targets: ['p1'])),
        ]));
  });
}
