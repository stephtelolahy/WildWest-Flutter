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

  test('can loose health if hit', () {
    // Given
    final player1 = GPlayer(id: 'p1', health: 2);
    final hit = GHit(players: ['p1'], abilities: ['looseHealth']);
    final state = GState(players: [player1], hit: hit);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, equals([GMove(ability: 'looseHealth', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventLooseHealth(player: 'p1'),
          GEventRemoveHit(player: 'p1'),
        ]));
  });

  test('can be eliminated if hit with last health', () {
    // Given
    final player1 = GPlayer(id: 'p1', health: 1);
    final hit = GHit(players: ['p1'], abilities: ['looseHealth']);
    final state = GState(players: [player1], hit: hit);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, equals([GMove(ability: 'looseHealth', actor: 'p1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventEliminate(player: 'p1'),
          GEventRemoveHit(player: 'p1'),
        ]));
  });
}
