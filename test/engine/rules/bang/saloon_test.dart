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

  test('can play saloon if some player damaged', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['saloon'], type: CardType.brown);
    final player1 =
        GPlayer(identifier: 'p1', hand: [card1], health: 4, attributes: CardAttributes(bullets: 4));
    final player2 = GPlayer(identifier: 'p2', health: 1, attributes: CardAttributes(bullets: 4));
    final player3 = GPlayer(identifier: 'p3', health: 3, attributes: CardAttributes(bullets: 4));
    final state = GState(
        players: [player1, player2, player3], playOrder: ['p3', 'p1', 'p2'], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, equals([GMove(ability: 'saloon', actor: 'p1', handCard: 'c1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventGainHealth(player: 'p2'),
          GEventGainHealth(player: 'p3'),
        ]));
  });

  test('cannot play saloon if all players full life', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['saloon'], type: CardType.brown);
    final player1 =
        GPlayer(identifier: 'p1', hand: [card1], health: 4, attributes: CardAttributes(bullets: 4));
    final player2 = GPlayer(identifier: 'p2', health: 4, attributes: CardAttributes(bullets: 4));
    final state =
        GState(players: [player1, player2], playOrder: ['p1', 'p2'], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, isEmpty);
  });
}
