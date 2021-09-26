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

  test('put card in other inplay if handicap', () {
    // Given
    final card1 = GCard(id: 'c1', abilities: ['handicap']);
    final player1 = GPlayer(id: 'p1', hand: [card1]);
    final player2 = GPlayer(id: 'p2');
    final player3 = GPlayer(id: 'p3');
    final state = GState(
        players: [player1, player2, player3], playOrder: ['p1', 'p2', 'p3'], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(
        moves,
        equals([
          GMove(ability: 'handicap', actor: 'p1', handCard: 'c1', target: 'p2'),
          GMove(ability: 'handicap', actor: 'p1', handCard: 'c1', target: 'p3')
        ]));
    final events = sut.effects(moves.first, state);
    expect(events, equals([GEventHandicap(player: 'p1', card: 'c1', other: 'p2')]));
  });

  test('cannot play handicap if target has same card in play', () {
    // Given
    final card1 = GCard(id: 'c1', name: 'n1', abilities: ['handicap']);
    final card2 = GCard(name: 'n1');
    final player1 = GPlayer(id: 'p1', hand: [card1]);
    final player2 = GPlayer(id: 'p2', inPlay: [card2]);
    final state =
        GState(players: [player1, player2], playOrder: ['p1', 'p2'], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, isEmpty);
  });
}
