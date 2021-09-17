import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/resources/loader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('load abilities', () async {
    // Given
    // When
    final result = await ResLoader().loadAbilities();

    // Assert
    expect(result, isNotEmpty);
  });

  test('load cards', () async {
    // Given
    // When
    final result = await ResLoader().loadCards();

    // Assert
    expect(result, isNotEmpty);
  });

  test('load card values', () async {
    // Given
    // When
    final result = await ResLoader().loadCardValues();

    // Assert
    expect(result, isNotEmpty);
  });
}
