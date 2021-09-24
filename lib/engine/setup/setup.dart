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
    required List<GCard> defaults,
    required List<GCard> deck,
  }) {
    final defaultFigure = defaults.firstWhere((e) => e.name == 'default');
    final sheriffFigure = defaults.firstWhere((e) => e.name == 'sheriff');

    roles.shuffle();
    figures.shuffle();
    deck.shuffle();

    final List<GPlayer> players = [];
    late String sheriff;
    for (var i = 0; i < roles.length; i++) {
      final role = roles[i];
      final figure = figures[i];

      var attributes = figure.attributes;
      var abilities = List<String>.from(figure.abilities);

      attributes = attributes.mergeWith(defaultFigure.attributes);
      abilities.addAll(defaultFigure.abilities);

      if (role == Role.sheriff) {
        sheriff = figure.name;
        attributes = attributes.mergeWith(sheriffFigure.attributes);
        abilities.addAll(sheriffFigure.abilities);
      }

      final health = attributes.bullets!;
      final hand = List.generate(health, (_) => deck.removeAt(0));
      players.add(GPlayer(
        identifier: figure.name,
        name: figure.name,
        desc: figure.desc,
        attributes: attributes,
        abilities: abilities,
        role: role,
        health: health,
        hand: hand,
        inPlay: [],
      ));
    }
    final playOrder = players.map((e) => e.identifier).toList();
    return GState(
      players: players,
      playOrder: playOrder,
      turn: sheriff,
      phase: 1,
      deck: deck,
      discard: [],
      store: [],
      played: [],
      history: [],
      hit: null,
      winner: null,
    );
  }
}

extension Merging on CardAttributes {
  CardAttributes mergeWith(CardAttributes other) => CardAttributes(
        bullets: [bullets, other.bullets].sum(),
        mustang: [mustang, other.mustang].sum(),
        scope: [scope, other.scope].sum(),
        weapon: [weapon, other.weapon].max(),
        flippedCards: [flippedCards, other.flippedCards].max(),
        bangsPerTurn: [bangsPerTurn, other.bangsPerTurn].max(),
        handLimit: [handLimit, other.handLimit].max(),
        silentCard: silentCard ?? other.silentCard,
        playAs: playAs ?? other.playAs,
        silentAbility: silentAbility ?? other.silentAbility,
      );
}

extension MerginOptionalInt on List<int?> {
  int? sum() {
    final values = this.whereType<int>().toList();
    final result = values.isNotEmpty ? values.reduce((a, b) => a + b) : null;
    return result;
  }

  int? max() {
    final values = this.whereType<int>().toList();
    final result = values.isNotEmpty ? values.reduce((a, b) => a > b ? a : b) : null;
    return result;
  }
}
