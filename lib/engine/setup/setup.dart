import '../state/state.dart';
import 'card_value.dart';

abstract class Setup {
  List<Role> roles({required int playersCount});
  List<GCard> setupDeck({required List<GCard> cards, required List<CardValue> values});
  GState setupGame({
    required List<Role> roles,
    required List<GCard> figures,
    required List<GCard> deck,
    Role preferredRole,
    String preferredFigure,
  });
}
