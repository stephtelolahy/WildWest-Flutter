import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('update flag if setting phase', () {
    // Given
    final state = GState(phase: 1);
    final event = GEventSetPhase(phase: 2);

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.phase, equals(2));
    expect(event.duration(), isNotNull);
  });
}
