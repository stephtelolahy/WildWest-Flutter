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

  test('discard all cards on eliminating deputy', () {
    // Given
    final player1 = GPlayer(
        identifier: 'p1',
        abilities: ['discardAllCardsOnEliminatingDeputy'],
        hand: [GCard(identifier: 'c1')],
        inPlay: [GCard(identifier: 'c2')]);
    final player2 = GPlayer(identifier: 'p2', role: Role.deputy);
    final state = GState(players: [player1, player2], playOrder: ['p1'], turn: 'p1');
    final event = GEventEliminate(player: 'p2');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'discardAllCardsOnEliminatingDeputy', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventDiscardInPlay(player: 'p1', card: 'c2'),
        ]));
  });
}
