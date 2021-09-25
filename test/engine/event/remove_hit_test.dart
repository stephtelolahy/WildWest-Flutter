import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('update players if removing hit', () {
    // Given
    final state = GState(hit: GHit(players: ['p1', 'p2']));
    final event = GEventRemoveHit(player: 'p1');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.hit?.players, equals(['p2']));
  });

  test('update both targets and players if removing hit', () {
    // Given
    final state = GState(hit: GHit(players: ['p1', 'p1'], targets: ['p2', 'p3']));
    final event = GEventRemoveHit(player: 'p1');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.hit?.players, equals(['p1']));
    expect(result.hit?.targets, equals(['p3']));
  });

  test('unset hit completely if removing hit', () {
    // Given
    final state = GState(hit: GHit(players: ['p1']));
    final event = GEventRemoveHit(player: 'p1');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.hit, isNull);
  });
}
