import 'package:flutter_test/flutter_test.dart';
import 'package:wildwest_flutter/engine/rules/rules.dart';
import 'package:wildwest_flutter/engine/setup/loader.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

void main() {
  final players = [
    GPlayer(identifier: 'sheriff', role: Role.sheriff),
    GPlayer(identifier: 'outlaw', role: Role.outlaw),
    GPlayer(identifier: 'renegade', role: Role.renegade),
    GPlayer(identifier: 'deputy', role: Role.deputy)
  ];

  late GRules sut;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final abilities = await ResLoader().loadAbilities();
    sut = GRules(abilities: abilities);
  });

  test('outlaw wins if sheriff is eliminated', () {
    // Given
    final state = GState(players: players, playOrder: ['outlaw', 'renegade', 'deputy']);

    // When
    final winner = sut.isGameOver(state);

    // Assert
    expect(winner, equals(Role.outlaw));
  });

  test('renegade wins if last alive', () {
    // Given
    final state = GState(players: players, playOrder: ['renegade']);

    // When
    final winner = sut.isGameOver(state);

    // Assert
    expect(winner, equals(Role.renegade));
  });

  test('sheriff wins if outlaw and renegates are eliminated', () {
    // Given
    final state = GState(players: players, playOrder: ['sheriff', 'deputy']);

    // When
    final winner = sut.isGameOver(state);

    // Assert
    expect(winner, equals(Role.sheriff));
  });
}
