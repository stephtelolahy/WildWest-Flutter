import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('set player health to zero if eliminating', () {
    // Given
    final state = GState(players: [GPlayer(identifier: 'p1', health: 3)]);
    final event = GEventEliminate(player: 'p1');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.player(identifier: 'p1').health, equals(0));
    expect(event.duration(), isNotNull);
  });

  test('remove player from playOrder if eliminating', () {
    // Given
    final state = GState(players: [GPlayer(identifier: 'p1')], playOrder: ['p3', 'p1', 'p2']);
    final event = GEventEliminate(player: 'p1');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.playOrder, equals(['p3', 'p2']));
  });

  test('remove player from hit if eliminating', () {
    // Given
    final state = GState(players: [GPlayer(identifier: 'p1')], hit: GHit(players: ['p1', 'p2']));
    final event = GEventEliminate(player: 'p1');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.hit?.players, equals(['p2']));
  });

  test('remove hit if eliminating', () {
    // Given
    final state = GState(players: [GPlayer(identifier: 'p1')], hit: GHit(players: ['p1']));
    final event = GEventEliminate(player: 'p1');

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.hit, isNull);
  });
}
