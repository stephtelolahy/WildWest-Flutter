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

  test('trigger start turn drawing two cards on phase 1', () {
    // Given
    final player1 = GPlayer(id: 'p1', abilities: ['startTurnDrawing2Cards']);
    final state = GState(players: [player1], playOrder: ['p1'], turn: 'p1', phase: 1);
    final event = GEventIdle();

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'startTurnDrawing2Cards', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDrawDeck(player: 'p1'),
          GEventDrawDeck(player: 'p1'),
          GEventSetPhase(phase: 2)
        ]));
  });
}
