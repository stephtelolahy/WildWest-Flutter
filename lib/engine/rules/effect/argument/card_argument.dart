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
    return [];
  }
}
