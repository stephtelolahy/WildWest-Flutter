import '../state/state.dart';
import 'card_value.dart';

class GSetup {
  List<Role> roles({required int playersCount}) {
    final List<Role> orderedRoles = [
      Role.sheriff,
      Role.outlaw,
      Role.outlaw,
      Role.renegade,
      Role.deputy,
      Role.outlaw,
      Role.deputy,
      Role.renegade,
    ];

    if (playersCount >= orderedRoles.length) {
      return [];
    }

    return orderedRoles.sublist(0, playersCount);
  }

  List<GCard> deck({required List<GCard> cards, required List<CardValue> values}) {
    return [];
  }

  GState game({
    required List<Role> roles,
    required List<GCard> figures,
    required List<GCard> deck,
    Role? preferredRole,
    String? preferredFigure,
  }) {
    return GState();
  }
}
