import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/rules/state_extensions.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  test('matching regex', () {
    // Given
    // When
    // Assert
    expect(GCard(name: 'jail', value: 'Q♠️', id: 'jail-Q♠️').matchesRegex('jail'), isTrue);
  });
}
