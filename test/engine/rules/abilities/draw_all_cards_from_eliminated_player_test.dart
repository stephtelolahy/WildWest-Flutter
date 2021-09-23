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

  test('take all cards from just eliminated player', () {
    // Given
    final card1 = GCard(identifier: 'c1');
    final card2 = GCard(identifier: 'c2');
    final card3 = GCard(identifier: 'c3');
    final card4 = GCard(identifier: 'c4');
    final player1 = GPlayer(identifier: 'p1', abilities: ['drawAllCardsFromEliminatedPlayer']);
    final player2 = GPlayer(identifier: 'p2', hand: [card1, card2], inPlay: [card3, card4]);

    final state = GState(players: [player1, player2], playOrder: ['p1']);
    final event = GEventEliminate(player: 'p2');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(
        moves,
        equals([
          GMove(
              ability: 'drawAllCardsFromEliminatedPlayer',
              actor: 'p1',
              args: PlayArgs(target: 'p2'))
        ]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDrawHand(player: 'p1', other: 'p2', card: 'c1'),
          GEventDrawHand(player: 'p1', other: 'p2', card: 'c2'),
          GEventDrawInPlay(player: 'p1', other: 'p2', card: 'c3'),
          GEventDrawInPlay(player: 'p1', other: 'p2', card: 'c4'),
        ]));
  });

  test('do not take all cards if self eliminated', () {
    // Given
    final card1 = GCard(identifier: 'c1');
    final card2 = GCard(identifier: 'c2');
    final player1 = GPlayer(
      identifier: 'p1',
      abilities: ['drawAllCardsFromEliminatedPlayer'],
      hand: [card1],
      inPlay: [card2],
    );

    final state = GState(players: [player1]);
    final event = GEventEliminate(player: 'p1');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, isEmpty);
  });
}
