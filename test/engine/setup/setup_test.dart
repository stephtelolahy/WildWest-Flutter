import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/setup/setup.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  final sut = GSetup();

  test('roles for 4 players', () async {
    // Given
    // When
    // Assert
    expect(
        sut.roles(playersCount: 4),
        equals([
          Role.sheriff,
          Role.outlaw,
          Role.outlaw,
          Role.renegade,
        ]));
  });

  test('roles for 5 players', () async {
    // Given
    // When
    // Assert
    expect(sut.roles(playersCount: 5),
        equals([Role.sheriff, Role.outlaw, Role.outlaw, Role.renegade, Role.deputy]));
  });

  test('roles for 6 players', () async {
    // Given
    // When
    // Assert
    expect(
        sut.roles(playersCount: 6),
        equals([
          Role.sheriff,
          Role.outlaw,
          Role.outlaw,
          Role.renegade,
          Role.deputy,
          Role.outlaw,
        ]));
  });

  test('roles for 7 players', () async {
    // Given
    // When
    // Assert
    expect(
        sut.roles(playersCount: 7),
        equals([
          Role.sheriff,
          Role.outlaw,
          Role.outlaw,
          Role.renegade,
          Role.deputy,
          Role.outlaw,
          Role.deputy,
        ]));
  });
}
