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
  List<String> get(PlayContext ctx) {
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
        return [ctx.args!.requiredTargetCard!];

      default:
        throw Exception('Unimplemented argument: $this');
    }
  }
}
