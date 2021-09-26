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

  test('can end turn if your turn phase 2', () {
    // Given
    final player1 = GPlayer(id: 'p1', abilities: ['endTurn']);
    final state = GState(players: [player1], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, equals([GMove(ability: 'endTurn', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(events, equals([GEventSetPhase(phase: 3)]));
  });
}
