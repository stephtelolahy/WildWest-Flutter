import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/move/move.dart';
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

  test('can play panic to draw other s hand', () {
    // Given
    final card1 = GCard(id: 'c1', abilities: ['panic'], type: CardType.brown);
    final player1 = GPlayer(id: 'p1', hand: [card1]);
    final player2 = GPlayer(id: 'p2', hand: [GCard(id: 'c2')]);
    final player3 = GPlayer(id: 'p3');
    final state = GState(
        players: [player1, player2, player3], playOrder: ['p1', 'p2', 'p3'], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(
        moves,
        equals([
          GMove(
              ability: 'panic', actor: 'p1', handCard: 'c1', target: 'p2', requiredTargetCard: ''),
        ]));

    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventDrawHand(player: 'p1', other: 'p2', card: 'c2'),
        ]));
  });

  test('can play panic to draw other s inPlay', () {
    // Given
    final card1 = GCard(id: 'c1', abilities: ['panic'], type: CardType.brown);
    final player1 = GPlayer(id: 'p1', hand: [card1]);
    final player2 = GPlayer(id: 'p2', inPlay: [GCard(id: 'c2')]);
    final player3 = GPlayer(id: 'p3');
    final state = GState(
        players: [player1, player2, player3], playOrder: ['p1', 'p2', 'p3'], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(
        moves,
        equals([
          GMove(
              ability: 'panic', actor: 'p1', handCard: 'c1', target: 'p2', requiredTargetCard: 'c2')
        ]));

    final events1 = sut.effects(moves.first, state);
    expect(
        events1,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventDrawInPlay(player: 'p1', other: 'p2', card: 'c2'),
        ]));
  });
}
