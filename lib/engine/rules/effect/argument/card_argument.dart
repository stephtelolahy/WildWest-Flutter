part of '../effect.dart';

enum CardArgument {
  requiredHand,
  randomHand,
  requiredTargetCard,
  requiredStore,
  requiredDeck,
  played,
  allHand,
  allInPlay,
}

extension GettingCards on CardArgument {
  List<String> get(PlayContext ctx, {String? player}) {
    switch (this) {
      case CardArgument.played:
        final handCard = ctx.handCard;
        final inPlayCard = ctx.inPlayCard;
        if (handCard != null) {
          return [handCard];
        }
        if (inPlayCard != null) {
          return [inPlayCard];
        }
        return [];

      case CardArgument.requiredStore:
        return [ctx.args!.requiredStore!];

      case CardArgument.requiredTargetCard:
        String cardId = ctx.args!.requiredTargetCard!;
        if (cardId.isEmpty) {
          final playerObject = ctx.state.player(identifier: player);
          cardId = playerObject.hand.randomElement().identifier;
        }
        return [cardId];

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
