import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('move card from hand to inPlay', () {
    // Given
    final card1 = GCard(id: 'c1');
    final card2 = GCard(id: 'c2');
    final player1 = GPlayer(id: 'p1', hand: [card1], inPlay: [card2]);
    final state = GState(players: [player1]);
    final event = GEventEquip(player: 'p1', card: 'c1');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.player(id: 'p1').hand, isEmpty);
    expect(result.player(id: 'p1').inPlay.map((e) => e.id), equals(['c2', 'c1']));
    expect(event.duration(), isNotNull);
  });
}
