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

  test('trigger choice of start turn drawing first card from other player', () {
    // Given
    final player1 = GPlayer(id: 'p1', abilities: ['startTurnChoosingDrawPlayer']);
    final state = GState(players: [player1], playOrder: ['p1'], turn: 'p1', phase: 1);
    final event = GEventIdle();

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'startTurnChoosingDrawPlayer', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventSetHit(
              hit: GHit(
            name: 'startTurnChoosingDrawPlayer',
            players: ['p1'],
            abilities: ['startTurnDrawingPlayer', 'startTurnDrawingDeck'],
          ))
        ]));
  });

  test('can start turn drawing first card from other player', () {
    // Given
    final player1 = GPlayer(id: 'p1');
    final player2 = GPlayer(id: 'p2', hand: [GCard(id: 'c2')]);
    final hit = GHit(
      name: 'startTurnChoosingDrawPlayer',
      players: ['p1'],
      abilities: ['startTurnDrawingPlayer', 'startTurnDrawingDeck'],
    );
    final state = GState(players: [player1, player2], playOrder: ['p1', 'p2'], hit: hit);

    // When
    final moves = sut.active(state);

    // Assert
    expect(
        moves,
        equals([
          GMove(ability: 'startTurnDrawingPlayer', actor: 'p1', args: PlayArgs(target: 'p2')),
          GMove(ability: 'startTurnDrawingDeck', actor: 'p1')
        ]));

    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDrawHand(player: 'p1', other: 'p2', card: 'c2'),
          GEventDrawDeck(player: 'p1'),
          GEventRemoveHit(player: 'p1'),
          GEventSetPhase(phase: 2),
        ]));
  });
}
