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

  test('draw card on loose health', () {
    // Given
    final player1 = GPlayer(id: 'p1', abilities: ['drawCardOnLoseHealth']);
    final state = GState(players: [player1], playOrder: ['p1']);
    final event = GEventLooseHealth(player: 'p1');

    // When
    final moves = sut.triggered(event, state);

    // Assert
    expect(moves, equals([GMove(ability: 'drawCardOnLoseHealth', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(events, equals([GEventDrawDeck(player: 'p1')]));
  });
}