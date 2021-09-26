import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('add card to stpre if drawing deck to store', () {
    // Given
    final card1 = GCard(id: 'c1');
    final card2 = GCard(id: 'c2');
    final card3 = GCard(id: 'c3');
    final player1 = GPlayer(id: 'p1');
    final state = GState(players: [player1], deck: [card1, card2, card3]);
    final event = GEventDeckToStore();

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.store.map((e) => e.id), ['c1']);
    expect(result.deck.map((e) => e.id), equals(['c2', 'c3']));
    expect(event.duration(), isNotNull);
  });
}
