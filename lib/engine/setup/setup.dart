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
    return values.map((cardValue) {
      final card = cards.firstWhere((e) => e.name == cardValue.name);
      return GCard(
        identifier: '${card.name}-${cardValue.value}',
        name: card.name,
        desc: card.desc,
        type: card.type,
        abilities: card.abilities,
        attributes: card.attributes,
        value: cardValue.value,
      );
    }).toList();
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
