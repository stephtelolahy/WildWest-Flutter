import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/rules/rules.dart';
import 'package:wildwest_flutter/engine/setup/loader.dart';
import 'package:wildwest_flutter/engine/state/state.dart';
import 'package:wildwest_flutter/engine/event/event.dart';

void main() {
  late GRules sut;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final abilities = await ResLoader().loadAbilities();
    sut = GRules(abilities: abilities);
  });

  test('do not trigger start turn if silenced', () {
    // Given
    final player1 = GPlayer(
      id: 'p1',
      abilities: ['startTurnDrawing2Cards'],
      silentAbility: 'startTurnDrawing2Cards',
    );
    final state = GState(players: [player1], turn: 'p1', phase: 1, playOrder: ['p1']);
    final event = GEventIdle();

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, isEmpty);
  });
}
