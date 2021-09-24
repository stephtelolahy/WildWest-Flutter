import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/setup/card_value.dart';
import 'package:wildwest_flutter/engine/setup/setup.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  final sut = GSetup();

  test('roles for 4 players', () {
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

  test('roles for 5 players', () {
    // Given
    // When
    // Assert
    expect(sut.roles(playersCount: 5),
        equals([Role.sheriff, Role.outlaw, Role.outlaw, Role.renegade, Role.deputy]));
  });

  test('roles for 6 players', () {
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

  test('roles for 7 players', () {
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

  test('build deck', () {
    // Given
    final cards = [
      GCard(name: 'n1', type: CardType.brown),
      GCard(name: 'n2', type: CardType.blue),
      GCard(name: 'n3', type: CardType.figure),
      GCard(name: 'n4', type: CardType.none),
    ];

    final values = [
      CardValue(name: 'n1', value: 'v11'),
      CardValue(name: 'n1', value: 'v12'),
      CardValue(name: 'n2', value: 'v21'),
      CardValue(name: 'n2', value: 'v22'),
    ];

    // When
    final deck = sut.deck(cards: cards, values: values);

    // Assert
    expect(
        deck,
        equals([
          GCard(identifier: 'n1-v11', name: 'n1', type: CardType.brown, value: 'v11'),
          GCard(identifier: 'n1-v12', name: 'n1', type: CardType.brown, value: 'v12'),
          GCard(identifier: 'n2-v21', name: 'n2', type: CardType.blue, value: 'v21'),
          GCard(identifier: 'n2-v22', name: 'n2', type: CardType.blue, value: 'v22'),
        ]));
  });
}
