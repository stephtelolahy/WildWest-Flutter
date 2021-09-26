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

  test('should discard excess cards on ending turn', () {
    // Given
    final player1 = GPlayer(
        id: 'p1',
        abilities: ['discardExcessCardsOnPhase3'],
        health: 1,
        hand: [
          GCard(),
          GCard(),
          GCard(),
        ]);
    final state = GState(players: [player1], playOrder: ['p1'], turn: 'p1');
    final event = GEventSetPhase(phase: 3);

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'discardExcessCardsOnPhase3', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventSetHit(
              hit: GHit(
                  name: 'discardExcessCardsOnPhase3',
                  players: ['p1', 'p1'],
                  abilities: ['discardSelfHand']))
        ]));
  });

  test('discard excess hand', () {
    // Given
    final player1 = GPlayer(id: 'p1', health: 1, hand: [GCard(id: 'c1'), GCard(id: 'c2')]);
    final hit =
        GHit(name: 'discardExcessCardsOnPhase3', players: ['p1'], abilities: ['discardSelfHand']);
    final state = GState(players: [player1], hit: hit);

    // When
    final moves = sut.active(state);

    // Assert
    expect(
        moves,
        equals([
          GMove(ability: 'discardSelfHand', actor: 'p1', requiredHand: ['c1']),
          GMove(ability: 'discardSelfHand', actor: 'p1', requiredHand: ['c2']),
        ]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventRemoveHit(player: 'p1'),
        ]));
  });
}
