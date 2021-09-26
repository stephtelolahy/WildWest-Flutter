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

  test('draw card from player damages him', () {
    // Given
    final player1 = GPlayer(id: 'p1', abilities: ['drawCardFromOffenderOnLoseHealth']);
    final player2 = GPlayer(id: 'p2', hand: [GCard(id: 'c2')]);

    final state = GState(players: [player1, player2], playOrder: ['p1', 'p2'], turn: 'p2');
    final event = GEventLooseHealth(player: 'p1');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves,
        equals([GMove(ability: 'drawCardFromOffenderOnLoseHealth', actor: 'p1', target: 'p2')]));
    final events = sut.effects(moves.first, state);
    expect(events, equals([GEventDrawHand(player: 'p1', other: 'p2', card: 'c2')]));
  });

  test('cannot draw card from player damages him if hand empty', () {
    // Given
    final player1 = GPlayer(id: 'p1', abilities: ['drawCardFromOffenderOnLoseHealth']);
    final player2 = GPlayer(id: 'p2');

    final state = GState(players: [player1, player2], playOrder: ['p1', 'p2'], turn: 'p2');
    final event = GEventLooseHealth(player: 'p1');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, isEmpty);
  });

  test('cannot draw card from player damages him if himself', () {
    // Given
    final player1 =
        GPlayer(id: 'p1', abilities: ['drawCardFromOffenderOnLoseHealth'], hand: [GCard(id: 'c1')]);
    final player2 = GPlayer(id: 'p2');

    final state = GState(players: [player1, player2], playOrder: ['p1', 'p2'], turn: 'p1');
    final event = GEventLooseHealth(player: 'p1');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, isEmpty);
  });
}
