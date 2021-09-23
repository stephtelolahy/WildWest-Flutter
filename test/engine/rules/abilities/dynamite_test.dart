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

  test('dynamite explodes if flipped card is between 2 and 9 spades', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['dynamite']);
    final player1 = GPlayer(identifier: 'p1', inPlay: [card1]);
    final state = GState(
      players: [player1],
      playOrder: ['p1'],
      turn: 'p1',
      deck: [GCard(value: '5♠️')],
    );
    final event = GEventSetPhase(phase: 1);

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'dynamite', actor: 'p1', inPlayCard: 'c1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventFlipDeck(),
          GEventSetHit(
              hit: GHit(name: 'dynamite', players: ['p1', 'p1', 'p1'], abilities: ['looseHealth'])),
          GEventDiscardInPlay(player: 'p1', card: 'c1'),
        ]));
  });

  test('pass dynamite if flipped card is not between 2 and 9 spades', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['dynamite']);
    final player1 = GPlayer(identifier: 'p1', inPlay: [card1]);
    final player2 = GPlayer(identifier: 'p2');
    final state = GState(
      players: [player1, player2],
      playOrder: ['p1', 'p2'],
      turn: 'p1',
      deck: [GCard(value: 'K♠️')],
    );
    final event = GEventSetPhase(phase: 1);

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'dynamite', actor: 'p1', inPlayCard: 'c1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventFlipDeck(),
          GEventPassInPlay(player: 'p1', card: 'c1', other: 'p2'),
        ]));
  });
}
