import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('add card to hand if drawing deck', () {
    // Given
    final card1 = GCard(identifier: 'c1');
    final card2 = GCard(identifier: 'c2');
    final card3 = GCard(identifier: 'c3');
    final player1 = GPlayer(identifier: 'p1');
    final state = GState(players: [player1], deck: [card1, card2, card3]);
    final event = GEventDrawDeck(player: 'p1');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.player(identifier: 'p1').hand.map((e) => e.identifier), ['c1']);
    expect(result.deck.map((e) => e.identifier), equals(['c2', 'c3']));
  });
}
