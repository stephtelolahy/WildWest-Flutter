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
          GCard(identifier: 'n1-v11', name: 'n1', type: CardType.brown, value: 'v11'),
          GCard(identifier: 'n1-v12', name: 'n1', type: CardType.brown, value: 'v12'),
          GCard(identifier: 'n2-v21', name: 'n2', type: CardType.blue, value: 'v21'),
          GCard(identifier: 'n2-v22', name: 'n2', type: CardType.blue, value: 'v22'),
        ]));
  });

  test('build game', () {
    // Given
    final roles = [
      Role.sheriff,
      Role.outlaw,
    ];

    final figures = [
      GCard(
        name: 'p1',
        type: CardType.figure,
        attributes: CardAttributes(bullets: 3),
        abilities: ['a1'],
      ),
      GCard(
        name: 'p2',
        type: CardType.figure,
        attributes: CardAttributes(bullets: 3),
        abilities: ['a2'],
      ),
    ];

    final defaults = [
      GCard(
        name: 'default',
        type: CardType.none,
        attributes: CardAttributes(),
        abilities: ['def'],
      ),
      GCard(
        name: 'sheriff',
        type: CardType.none,
        attributes: CardAttributes(bullets: 1),
        abilities: ['she'],
      ),
    ];

    final deck = List.generate(10, (index) => GCard(identifier: 'c${index + 1}'));

    // When
    final state = sut.game(roles: roles, figures: figures, defaults: defaults, deck: deck);

    // Assert
    expect(state.players.length, equals(2));
    expect(state.playOrder, ['p1', 'p2']);
    expect(state.turn, equals('p1'));
    expect(state.phase, 1);
    expect(state.discard, isEmpty);
    expect(state.store, isEmpty);
    expect(state.played, isEmpty);
    expect(state.history, isEmpty);
    expect(state.winner, isNull);
    expect(state.hit, isNull);

    final player1 = state.players[0];
    expect(player1.role, equals(Role.sheriff));
    expect(player1.identifier, equals('p1'));
    expect(player1.abilities, equals(['a1', 'def', 'she']));
    expect(player1.attributes, equals(CardAttributes(bullets: 4)));
    expect(player1.health, equals(4));
    expect(
        player1.hand,
        equals([
          GCard(identifier: 'c1'),
          GCard(identifier: 'c2'),
          GCard(identifier: 'c3'),
          GCard(identifier: 'c4')
        ]));
    expect(player1.inPlay, isEmpty);

    final player2 = state.players[1];
    expect(player2.role, equals(Role.outlaw));
    expect(player2.identifier, equals('p2'));
    expect(player2.abilities, equals(['a2', 'def']));
    expect(player2.attributes, equals(CardAttributes(bullets: 3)));
    expect(player2.health, equals(3));
    expect(
        player2.hand,
        equals([
          GCard(identifier: 'c5'),
          GCard(identifier: 'c6'),
          GCard(identifier: 'c7'),
        ]));
    expect(player1.inPlay, isEmpty);

    expect(
        state.deck,
        equals([
          GCard(identifier: 'c8'),
          GCard(identifier: 'c9'),
          GCard(identifier: 'c10'),
        ]));
  });
}
