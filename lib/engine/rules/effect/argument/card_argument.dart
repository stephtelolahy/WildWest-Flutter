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
        return List<String>.from([ctx.handCard, ctx.inPlayCard].where((e) => e == null));

      case CardArgument.requiredStore:
        return [ctx.args!.requiredStore!];

      case CardArgument.requiredTargetCard:
        String cardId = ctx.args!.requiredTargetCard!;
        if (cardId.isEmpty) {
          final playerObject = ctx.state.player(identifier: player);
          cardId = playerObject.hand.randomElement().identifier;
        }
        return [cardId];

      case CardArgument.allCards:
        final playerObject = ctx.state.player(identifier: player);
        return (playerObject.hand + playerObject.inPlay).map((e) => e.identifier).toList();

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
