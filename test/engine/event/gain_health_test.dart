import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('increment player health if gaining health', () {
    // Given
    final state = GState(players: [GPlayer(identifier: 'p1', health: 3)]);
    final event = GEventGainHealth(player: 'p1');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.player(identifier: 'p1').health, equals(4));
    expect(event.duration(), isNotNull);
  });
}
