import '../state/state.dart';
import 'card.dart';
import 'card_value.dart';

abstract class Setup {
  List<Role> roles({required int playersCount});
  List<GCard> setupDeck({required List<ResCard> cards, required List<ResCardValue> values});
  GState setupGame({
    required List<Role> roles,
    required List<ResCard> figures,
    required List<GCard> deck,
    Role preferredRole,
    String preferredFigure,
  });
}
