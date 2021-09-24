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

  test('trigger special abilities before default abilities if eliminated', () {
    // Given
    final player1 = GPlayer(
        identifier: 'p1',
        abilities: ['nextTurnOnEliminated', 'discardAllCardsOnEliminated'],
        hand: [GCard()]);
    final player2 = GPlayer(
      identifier: 'p2',
      abilities: ['drawAllCardsFromEliminated'],
    );
    final state = GState(players: [player1, player2], playOrder: ['p2'], turn: 'p1');
    final event = GEventEliminate(player: 'p1');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(
        moves,
        equals([
          GMove(ability: 'drawAllCardsFromEliminated', actor: 'p2', args: PlayArgs(target: 'p1')),
          GMove(ability: 'discardAllCardsOnEliminated', actor: 'p1'),
          GMove(ability: 'nextTurnOnEliminated', actor: 'p1'),
        ]));
  });

  test('trigger dynamite before jail', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['jail']);
    final card2 = GCard(identifier: 'c2', abilities: ['dynamite']);
    final player1 = GPlayer(identifier: 'p1', inPlay: [card1, card2]);
    final player2 = GPlayer(identifier: 'p2');
    final state =
        GState(players: [player1, player2], playOrder: ['p1', 'p2'], turn: 'p1', deck: [GCard()]);
    final event = GEventSetPhase(phase: 1);

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(
        moves,
        equals([
          GMove(ability: 'dynamite', actor: 'p1', inPlayCard: 'c2'),
          GMove(ability: 'jail', actor: 'p1', inPlayCard: 'c1'),
        ]));
  });
}
