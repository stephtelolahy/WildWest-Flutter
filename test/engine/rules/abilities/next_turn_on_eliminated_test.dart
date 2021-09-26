import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/move/move.dart';
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

  test('should next turn on eliminated', () {
    // Given
    final player1 = GPlayer(id: 'p1', abilities: ['nextTurnOnEliminated']);
    final player2 = GPlayer(id: 'p2');
    final state = GState(players: [player1, player2], playOrder: ['p2', 'p1'], turn: 'p1');
    final event = GEventEliminate(player: 'p1');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'nextTurnOnEliminated', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventSetTurn(player: 'p2'),
          GEventSetPhase(phase: 1),
        ]));
  });
}
