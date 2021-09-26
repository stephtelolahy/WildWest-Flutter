import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('do nothing if idle', () {
    // Given
    final state = GState();
    final event = GEventIdle();

    // When
    final result = event.dispatch(state);

    // Assert
    expect(result, isNull);
  });
}
