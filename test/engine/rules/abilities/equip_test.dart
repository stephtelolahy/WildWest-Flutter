import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/rules/rules.dart';
import 'package:wildwest_flutter/engine/setup/loader.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  late GRules sut;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final abilities = await ResLoader().loadAbilities();
    sut = GRules(abilities: abilities);
  });

  test('put card in play if equip', () {
    // Given
    final card1 = GCard(id: 'c1', abilities: ['equip']);
    final card2 = GCard(id: 'c2', abilities: ['equip']);
    final player1 = GPlayer(id: 'p1', hand: [card1, card2]);
    final state = GState(players: [player1], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(
        moves,
        equals([
          GMove(ability: 'equip', actor: 'p1', handCard: 'c1'),
          GMove(ability: 'equip', actor: 'p1', handCard: 'c2')
        ]));
    final events = sut.effects(moves.first, state);
    expect(events, equals([GEventEquip(player: 'p1', card: 'c1')]));
  });

  test('cannot equip two copies of the same card', () {
    // Given
    final card1 = GCard(id: 'c1', name: 'n1', abilities: ['equip']);
    final card2 = GCard(name: 'n1');
    final player1 = GPlayer(id: 'p1', hand: [card1], inPlay: [card2]);
    final state = GState(players: [player1], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, isEmpty);
  });

  test('discard previous weapon when equip new one', () {
    // Given
    final card1 = GCard(id: 'c1', abilities: ['equip'], weapon: 2);
    final card2 = GCard(id: 'c2', weapon: 1);
    final player1 = GPlayer(id: 'p1', hand: [card1], inPlay: [card2]);
    final state = GState(players: [player1], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, equals([GMove(ability: 'equip', actor: 'p1', handCard: 'c1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventEquip(player: 'p1', card: 'c1'),
          GEventDiscardInPlay(player: 'p1', card: 'c2')
        ]));
  });
}
