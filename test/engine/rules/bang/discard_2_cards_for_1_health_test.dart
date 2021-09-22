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

  test('can discard 2 cards for 1 health', () {
    // Given
    final player1 = GPlayer(
      identifier: 'p1',
      health: 2,
      attributes: CardAttributes(bullets: 4),
      abilities: ['discard2CardsFor1Health'],
      hand: [
        GCard(identifier: 'c1'),
        GCard(identifier: 'c2'),
        GCard(identifier: 'c3'),
      ],
    );
    final state = GState(players: [player1], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(
        moves,
        equals([
          GMove(
              ability: 'discard2CardsFor1Health',
              actor: 'p1',
              args: PlayArgs(requiredHand: ['c1', 'c2'])),
          GMove(
              ability: 'discard2CardsFor1Health',
              actor: 'p1',
              args: PlayArgs(requiredHand: ['c1', 'c3'])),
          GMove(
              ability: 'discard2CardsFor1Health',
              actor: 'p1',
              args: PlayArgs(requiredHand: ['c2', 'c3'])),
        ]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventDiscardHand(player: 'p1', card: 'c2'),
          GEventGainHealth(player: 'p1'),
        ]));
  });
}
