import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('draw hand', () {
    // Given
    final card1 = GCard(id: 'c1');
    final card2 = GCard(id: 'c2');
    final player1 = GPlayer(id: 'p1', hand: [card1]);
    final player2 = GPlayer(id: 'p2', hand: [card2]);
    final state = GState(players: [player1, player2]);
    final event = GEventDrawHand(player: 'p1', other: 'p2', card: 'c2');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.player(id: 'p1').hand.map((e) => e.id), ['c1', 'c2']);
    expect(result.player(id: 'p2').hand, isEmpty);
    expect(event.duration(), isNotNull);
  });
}
