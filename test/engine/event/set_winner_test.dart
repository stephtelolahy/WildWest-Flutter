import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('update flag if setting winner', () {
    // Given
    final state = GState();
    final event = GEventSetWinner(winner: Role.outlaw);

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.winner, equals(Role.outlaw));
  });
}
