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

  test('can play wellsFargo if some holding card', () {
    // Given
    final card1 = GCard(id: 'c1', abilities: ['wellsFargo'], type: CardType.brown);
    final player1 = GPlayer(id: 'p1', hand: [card1]);
    final state = GState(players: [player1], turn: 'p1', phase: 2);

    // When
    final moves = sut.active(state);

    // Assert
    expect(moves, equals([GMove(ability: 'wellsFargo', actor: 'p1', handCard: 'c1')]));
    final events = sut.effects(moves.first, state);
    expect(
        events,
        equals([
          GEventDiscardHand(player: 'p1', card: 'c1'),
          GEventDrawDeck(player: 'p1'),
          GEventDrawDeck(player: 'p1'),
          GEventDrawDeck(player: 'p1'),
        ]));
  });
}
