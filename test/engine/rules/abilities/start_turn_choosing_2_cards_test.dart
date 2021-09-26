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

  test('trigger start turn choosing 2 cards from deck', () {
    // Given
    final player1 = GPlayer(id: 'p1', abilities: ['startTurnChoosing2CardsFromDeck']);
    final state = GState(players: [player1], playOrder: ['p1'], turn: 'p1', phase: 1);
    final event = GEventIdle();

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'startTurnChoosing2CardsFromDeck', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventSetHit(
              hit: GHit(
            name: 'startTurnChoosing2CardsFromDeck',
            players: ['p1'],
            abilities: ['startTurnDrawingDeckChoosing'],
          ))
        ]));
  });

  test('must choose two cards from deck to start turn', () {
    // Given
    final player1 = GPlayer(id: 'p1');
    final hit = GHit(
      name: 'startTurnChoosing2CardsFromDeck',
      players: ['p1'],
      abilities: ['startTurnDrawingDeckChoosing'],
    );
    final state = GState(
        players: [player1],
        hit: hit,
        deck: [
          GCard(id: 'c1'),
          GCard(id: 'c2'),
          GCard(id: 'c3'),
        ]);

    // When
    final moves = sut.active(state);

    // Assert
    expect(
        moves,
        equals([
          GMove(ability: 'startTurnDrawingDeckChoosing', actor: 'p1', requiredDeck: ['c1', 'c2']),
          GMove(ability: 'startTurnDrawingDeckChoosing', actor: 'p1', requiredDeck: ['c1', 'c3']),
          GMove(ability: 'startTurnDrawingDeckChoosing', actor: 'p1', requiredDeck: ['c2', 'c3'])
        ]));

    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDrawDeckCard(player: 'p1', card: 'c1'),
          GEventDrawDeckCard(player: 'p1', card: 'c2'),
          GEventRemoveHit(player: 'p1'),
          GEventSetPhase(phase: 2),
        ]));
  });
}
