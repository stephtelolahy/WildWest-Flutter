import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('do nothing if activating moves', () {
    // Given
    final state = GState();
    final event = GEventActivate(moves: [GMove(ability: 'a1', actor: 'p1')]);

    // When
    final result = event.dispatch(state);

    // Assert
    expect(result, isNull);
  });
}
