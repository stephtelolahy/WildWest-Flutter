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

  test('cancel shoot if flipped card is hearts', () {
    // Given
    final card1 = GCard(id: 'c1', abilities: ['barrel']);
    final player1 = GPlayer(id: 'p1', inPlay: [card1]);
    final state = GState(
      players: [player1],
      playOrder: ['p1'],
      deck: [GCard(value: '2♥️')],
    );
    final event =
        GEventSetHit(hit: GHit(name: 'bang', players: ['p1'], abilities: ['cancelShoot']));

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'barrel', actor: 'p1', inPlayCard: 'c1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventFlipDeck(),
          GEventRemoveHit(player: 'p1'),
        ]));
  });

  test('do not cancel shoot flipped card is not hearts', () {
    // Given
    final card1 = GCard(id: 'c1', abilities: ['barrel']);
    final player1 = GPlayer(id: 'p1', inPlay: [card1]);
    final state = GState(
      players: [player1],
      playOrder: ['p1'],
      deck: [GCard(value: '5♣️')],
    );
    final event =
        GEventSetHit(hit: GHit(name: 'bang', players: ['p1'], abilities: ['cancelShoot']));

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'barrel', actor: 'p1', inPlayCard: 'c1')]));
    final events = sut.effects(moves.first, state);
    expect(events, equals([GEventFlipDeck()]));
  });
}
