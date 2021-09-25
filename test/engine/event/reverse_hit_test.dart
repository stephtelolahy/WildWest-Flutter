import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('permute player and target if reversing hit', () {
    // Given
    final state = GState(hit: GHit(players: ['p1'], targets: ['p2']));
    final event = GEventReverseHit();

    // When
    final result = event.dispatch(state);

    // Assert
    expect(result.hit?.players, equals(['p2']));
    expect(result.hit?.targets, equals(['p1']));
  });
}
