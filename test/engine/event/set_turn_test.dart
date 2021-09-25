import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('update flag if setting turn', () {
    // Given
    final state = GState(turn: 'p1');
    final event = GEventSetTurn(player: 'p2');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.turn, equals('p2'));
  });

  test('clear played if setting turn', () {
    // Given
    final state = GState(played: ['a1', 'a2']);
    final event = GEventSetTurn(player: 'p2');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.played, isEmpty);
  });
}
