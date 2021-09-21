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

  test('trigger choice of start turn drawing from discard', () {
    // Given
    final player1 = GPlayer(identifier: 'p1', abilities: ['startTurnChoosingDrawDiscard']);
    final state = GState(players: [player1], playOrder: ['p1'], turn: 'p1', phase: 1);
    final event = GEventIdle();

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'startTurnChoosingDrawDiscard', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventSetHit(
              hit: GHit(
            name: 'startTurnChoosingDrawDiscard',
            players: ['p1'],
            abilities: ['startTurnDrawingDiscard', 'startTurnDrawingDeck'],
          ))
        ]));
  });

  test('can start turn drawing from discard', () {
    // Given
    final player1 = GPlayer(identifier: 'p1');
    final hit = GHit(
      name: 'startTurnChoosingDrawDiscard',
      players: ['p1'],
      abilities: ['startTurnDrawingDiscard', 'startTurnDrawingDeck'],
    );
    final state = GState(players: [player1], hit: hit, discard: [GCard()]);

    // When
    final moves = sut.active(state);

    // Assert
    expect(
        moves,
        equals([
          GMove(ability: 'startTurnDrawingDiscard', actor: 'p1'),
          GMove(ability: 'startTurnDrawingDeck', actor: 'p1')
        ]));

    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDrawDiscard(player: 'p1'),
          GEventDrawDeck(player: 'p1'),
          GEventRemoveHit(player: 'p1'),
          GEventSetPhase(phase: 2),
        ]));
  });
}
