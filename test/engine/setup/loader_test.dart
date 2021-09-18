import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/setup/loader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  ResLoader sut = ResLoader();

  test('load abilities', () async {
    // Given
    // When
    final result = await sut.loadAbilities();

    // Assert
    expect(result, isNotEmpty);
  });

  test('load cards', () async {
    // Given
    // When
    final result = await sut.loadCards();

    // Assert
    expect(result, isNotEmpty);
  });

  test('load card values', () async {
    // Given
    // When
    final result = await sut.loadCardValues();

    // Assert
    expect(result, isNotEmpty);
  });
}
