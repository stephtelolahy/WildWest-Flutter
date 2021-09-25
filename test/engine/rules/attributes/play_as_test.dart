import 'package:flutter_test/flutter_test.dart';
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

  test('play missed as bang', () {
    // Given
    final card1 = GCard(id: 'c1', name: 'missed');
    final player1 = GPlayer(
      id: 'p1',
      playAs: {'missed': 'bang'},
      hand: [card1],
    );
    final player2 = GPlayer(id: 'p2');
    final state = GState(
      players: [player1, player2],
      turn: 'p1',
      phase: 2,
      playOrder: ['p1', 'p2'],
    );

    // When
    final moves = sut.active(state);

    // Assert
    expect(
        moves, [GMove(ability: 'bang', actor: 'p1', handCard: 'c1', args: PlayArgs(target: 'p2'))]);
  });

  test('play bang as missed', () {
    // Given
    final card1 = GCard(id: 'c1', name: 'bang');
    final player1 = GPlayer(
      id: 'p1',
      playAs: {'bang': 'missed'},
      hand: [card1],
    );
    final hit = GHit(name: 'gatling', players: ['p1'], abilities: ['cancelShoot']);
    final state = GState(players: [player1], hit: hit);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, [GMove(ability: 'missed', actor: 'p1', handCard: 'c1')]);
  });
}
