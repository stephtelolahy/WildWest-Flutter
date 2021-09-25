import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('move card from hand to discard', () {
    // Given
    final card1 = GCard(identifier: 'c1');
    final card2 = GCard(identifier: 'c2');
    final player1 = GPlayer(identifier: 'p1', hand: [card1]);
    final state = GState(players: [player1], discard: [card2]);
    final event = GEventDiscardHand(player: 'p1', card: 'c1');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.player(identifier: 'p1').hand, isEmpty);
    expect(result.discard.map((e) => e.identifier), equals(['c1', 'c2']));
    expect(event.duration(), isNotNull);
  });
}
