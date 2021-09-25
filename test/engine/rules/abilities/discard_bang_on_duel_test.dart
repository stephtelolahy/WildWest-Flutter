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

  test('can discard bang on duel to reverse hit', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['discardBangOnDuel'], type: CardType.brown);
    final player1 = GPlayer(identifier: 'p1', hand: [card1]);
    final hit = GHit(name: 'duel', players: ['p1']);
    final state = GState(players: [player1], hit: hit);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, contains(GMove(ability: 'discardBangOnDuel', actor: 'p1', handCard: 'c1')));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventReverseHit(),
        ]));
  });
}
