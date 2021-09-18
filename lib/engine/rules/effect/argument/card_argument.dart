part of '../effect.dart';

enum CardArgument {
  requiredHand,
  randomHand,
  requiredInPlay,
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

      default:
        throw Exception('Unimplemented argument: $this');
    }
  }
}
