import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/rules/effect/effect.dart';
import 'package:wildwest_flutter/engine/rules/play_req/play_req.dart';

void main() {
  test('starting with', () {
    // Given
    // When
    // Assert
    expect([1, 2, 3].startingWith(1), equals([1, 2, 3]));
    expect([1, 2, 3].startingWith(2), equals([2, 3, 1]));
    expect([1, 2, 3].startingWith(3), equals([3, 1, 2]));
  });

  test('combine by 1', () {
    // Given
    // When
    // Assert
    expect(
        [1, 2, 3].combineBy(2),
        equals([
          [1, 2],
          [1, 3],
          [2, 3]
        ]));
  });

  test('combine by 2', () {
    // Given
    // When
    // Assert
    expect(
        [1, 2, 3].combineBy(2),
        equals([
          [1, 2],
          [1, 3],
          [2, 3]
        ]));
  });
}
