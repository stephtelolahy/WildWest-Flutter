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

  test('draw 3 cards on eliminating outlaw', () {
    // Given
    final player1 = GPlayer(identifier: 'p1', abilities: ['draw3CardsOnEliminatingOutlaw']);
    final player2 = GPlayer(identifier: 'p2', role: Role.outlaw);
    final state = GState(players: [player1, player2], playOrder: ['p1'], turn: 'p1');
    final event = GEventEliminate(player: 'p2');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'draw3CardsOnEliminatingOutlaw', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDrawDeck(player: 'p1'),
          GEventDrawDeck(player: 'p1'),
          GEventDrawDeck(player: 'p1'),
        ]));
  });

  test('do not draw 3 cards is eliminated as outlaw', () {
    // Given
    final player1 =
        GPlayer(identifier: 'p1', role: Role.outlaw, abilities: ['draw3CardsOnEliminatingOutlaw']);
    final state = GState(players: [player1]);
    final event = GEventEliminate(player: 'p1');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, isEmpty);
  });
}
