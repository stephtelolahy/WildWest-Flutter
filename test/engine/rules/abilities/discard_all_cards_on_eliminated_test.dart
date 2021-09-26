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

  test('discard all cards on eliminated', () {
    // Given
    final player1 = GPlayer(
        id: 'p1',
        abilities: ['discardAllCardsOnEliminated'],
        hand: [GCard(id: 'c1')],
        inPlay: [GCard(id: 'c2')]);
    final state = GState(players: [player1]);
    final event = GEventEliminate(player: 'p1');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'discardAllCardsOnEliminated', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventDiscardInPlay(player: 'p1', card: 'c2'),
        ]));
  });

  test('do nothing if eliminated without cards', () {
    // Given
    final player1 = GPlayer(id: 'p1', abilities: ['discardAllCardsOnEliminated']);
    final state = GState(players: [player1]);
    final event = GEventEliminate(player: 'p1');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, isEmpty);
  });
}
