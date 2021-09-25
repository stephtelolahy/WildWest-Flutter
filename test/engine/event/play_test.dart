import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('add played ability if playing move', () {
    // Given
    final state = GState(played: ['a1']);
    final event = GEventPlay(move: GMove(ability: 'a2', actor: 'p1'));

    // When
    final result = event.dispatch(state);

    // Assert
    expect(result.played, equals(['a1', 'a2']));
  });

  test('add to history if playing move', () {
    // Given
    final state = GState();
    final event = GEventPlay(move: GMove(ability: 'a1', actor: 'p1'));

    // When
    final result = event.dispatch(state);

    // Assert
    expect(result.history, equals([GMove(ability: 'a1', actor: 'p1')]));
  });
}
