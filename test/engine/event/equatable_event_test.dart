import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';

void main() {
  test('esuatable events', () {
    // Given
    final event1 = GEventGainHealth(player: 'p1');
    final event2 = GEventDeckToStore();

    // When
    // Assert
    expect(event1, equals(GEventGainHealth(player: 'p1')));
    expect(event2, equals(GEventDeckToStore()));
    expect([event1, event2], equals([GEventGainHealth(player: 'p1'), GEventDeckToStore()]));
  });
}
