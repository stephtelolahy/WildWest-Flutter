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

  test('escape from jail if flipped card is hearts', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['jail']);
    final player1 = GPlayer(identifier: 'p1', inPlay: [card1]);
    final state = GState(
      players: [player1],
      playOrder: ['p1'],
      turn: 'p1',
      deck: [GCard(value: '7♥️')],
    );
    final event = GEventSetPhase(phase: 1);

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'jail', actor: 'p1', inPlayCard: 'c1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventFlipDeck(),
          GEventDiscardInPlay(player: 'p1', card: 'c1'),
        ]));
  });

  test('stay in jail if flipped card is not hearts', () {
    // Given
    final card1 = GCard(identifier: 'c1', abilities: ['jail']);
    final player1 = GPlayer(identifier: 'p1', inPlay: [card1]);
    final player2 = GPlayer(identifier: 'p2');
    final state = GState(
      players: [player1, player2],
      playOrder: ['p1', 'p2'],
      turn: 'p1',
      deck: [GCard(value: 'K♦️')],
    );
    final event = GEventSetPhase(phase: 1);

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'jail', actor: 'p1', inPlayCard: 'c1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventFlipDeck(),
          GEventSetTurn(player: 'p2'),
          GEventSetPhase(phase: 1),
          GEventDiscardInPlay(player: 'p1', card: 'c1'),
        ]));
  });
}
