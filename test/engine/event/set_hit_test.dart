import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('update flag if setting hit', () {
    // Given
    final state = GState();
    final event = GEventSetHit(
        hit: GHit(
      name: 'n1',
      players: ['p1', 'p2'],
      abilities: ['a1', 'a2'],
      targets: ['t1', 't2'],
    ));

    // When
    final result = event.dispatch(state)!;

    // Assert
    expect(result.hit?.name, equals('n1'));
    expect(result.hit?.players, equals(['p1', 'p2']));
    expect(result.hit?.abilities, equals(['a1', 'a2']));
    expect(result.hit?.targets, equals(['t1', 't2']));
  });
}
