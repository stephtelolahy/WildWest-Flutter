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

  test('flip 2 cards if having attribute', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['dynamite']);
    final player1 = GPlayer(
      identifier: 'p1',
      attributes: CardAttributes(flippedCards: 2),
      inPlay: [card1],
    );
    final player2 = GPlayer(identifier: 'p2');
    final state = GState(
      players: [player1, player2],
      playOrder: ['p1', 'p2'],
      turn: 'p1',
      deck: [GCard(value: '5♠️'), GCard(value: '4♥️')],
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
          GEventFlipDeck(),
          GEventPassInPlay(player: 'p1', card: 'c1', other: 'p2'),
        ]));
  });
}
