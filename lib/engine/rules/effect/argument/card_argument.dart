part of '../effect.dart';

enum CardArgument {
  requiredHand,
  randomHand,
  requiredTargetCard,
  requiredStore,
  requiredDeck,
  played,
  allCards
}

extension GettingCards on CardArgument {
  List<String> get(PlayContext ctx, {String? player}) {
    switch (this) {
      case CardArgument.played:
        final handCard = ctx.handCard;
        if (handCard != null) {
          return [handCard];
        }
        final inPlayCard = ctx.inPlayCard;
        if (inPlayCard != null) {
          return [inPlayCard];
        }
        return [];

      case CardArgument.requiredStore:
        return [ctx.args!.requiredStore!];

      case CardArgument.requiredTargetCard:
        String cardId = ctx.args!.requiredTargetCard!;
        if (cardId.isEmpty) {
          final playerObject = ctx.state.player(id: player);
          cardId = playerObject.hand.randomElement().id;
        }
        return [cardId];

      case CardArgument.allCards:
        final playerObject = ctx.state.player(id: player);
        return (playerObject.hand + playerObject.inPlay).map((e) => e.id).toList();

      case CardArgument.randomHand:
        final playerObject = ctx.state.player(id: player);
        if (playerObject.hand.isEmpty) {
          return [];
        }
        return [playerObject.hand.randomElement().id];

      case CardArgument.requiredHand:
        return ctx.args!.requiredHand;

      case CardArgument.requiredDeck:
        return ctx.args!.requiredDeck;

      default:
        throw Exception('Unimplemented argument: $this');
    }
  }
}

extension GettingRandomItem<T> on List<T> {
  T randomElement() {
    final random = new Random();
    var i = random.nextInt(this.length);
    return this[i];
  }
}
