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
    expect(
        sut.roles(playersCount: 5),
        equals([
          Role.sheriff,
          Role.outlaw,
          Role.outlaw,
          Role.renegade,
          Role.deputy,
        ]));
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
          GCard(id: 'n1-v11', name: 'n1', type: CardType.brown, value: 'v11'),
          GCard(id: 'n1-v12', name: 'n1', type: CardType.brown, value: 'v12'),
          GCard(id: 'n2-v21', name: 'n2', type: CardType.blue, value: 'v21'),
          GCard(id: 'n2-v22', name: 'n2', type: CardType.blue, value: 'v22'),
        ]));
  });

  test('build game', () {
    // Given
    final roles = sut.roles(playersCount: 5);

    final figures = List.generate(
        5,
        (index) => GCard(
              name: 'p${index + 1}',
              type: CardType.figure,
              bullets: 3,
            ));

    final defaults = [
      GCard(
        name: 'default',
        type: CardType.none,
        abilities: ['default'],
      ),
      GCard(name: 'sheriff', type: CardType.none, bullets: 1, abilities: ['sheriff']),
    ];

    final deck = List.generate(20, (index) => GCard(id: 'c${index + 1}'));

    // When
    final state = sut.game(roles: roles, figures: figures, defaults: defaults, deck: deck);

    // Assert

    final sheriff = state.players.firstWhere((e) => e.role == Role.sheriff);
    final other = state.players.firstWhere((e) => e.role != Role.sheriff);

    expect(state.players.length, equals(5));
    expect(state.playOrder.length, equals(5));
    expect(state.turn, equals(sheriff.id));
    expect(state.phase, 1);
    expect(state.discard, isEmpty);
    expect(state.store, isEmpty);
    expect(state.played, isEmpty);
    expect(state.history, isEmpty);
    expect(state.winner, isNull);
    expect(state.hit, isNull);

    expect(sheriff.abilities, contains('sheriff'));
    expect(sheriff.abilities, contains('default'));
    expect(sheriff.bullets, equals(4));
    expect(sheriff.health, equals(4));
    expect(sheriff.hand.length, equals(4));
    expect(sheriff.inPlay, isEmpty);

    expect(other.abilities, contains('default'));
    expect(other.bullets, equals(3));
    expect(other.health, equals(3));
    expect(other.hand.length, equals(3));
    expect(other.inPlay, isEmpty);

    expect(state.deck.length, equals(4));
  });
}
