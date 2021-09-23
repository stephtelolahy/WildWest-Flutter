import 'package:flutter_test/flutter_test.dart';
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

  test('cannot play jail if target has silent jail', () {
    // Given
    final card1 = GCard(identifier: 'c1', name: 'jail', abilities: ['handicap']);
    final player1 = GPlayer(identifier: 'p1', hand: [card1]);
    final player2 = GPlayer(identifier: 'p2', attributes: CardAttributes(silentCard: 'jail'));
    final state = GState(
      players: [player1, player2],
      playOrder: ['p1', 'p2'],
      turn: 'p1',
      phase: 2,
    );

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, isEmpty);
  });
}
