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

  test('should draw store', () {
    // Given
    final card1 = GCard(id: 'c1');
    final card2 = GCard(id: 'c2');
    final player1 = GPlayer(id: 'p1');
    final hit = GHit(players: ['p1', 'pX'], abilities: ['drawStore']);
    final state = GState(players: [player1], store: [card1, card2], hit: hit);

    // When
    final moves = sut.active(state);

    // Assert
    expect(
        moves,
        equals([
          GMove(ability: 'drawStore', actor: 'p1', requiredStore: 'c1'),
          GMove(ability: 'drawStore', actor: 'p1', requiredStore: 'c2'),
        ]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDrawStore(player: 'p1', card: 'c1'),
          GEventRemoveHit(player: 'p1'),
        ]));
  });
}
