part of 'effect.dart';

/*
 * Discard a card from player
 */
class Discard extends Effect {
  final PlayerArgument player;
  final CardArgument card;

  Discard.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!,
        card = EnumToString.fromString(CardArgument.values, json['card']!)!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final playerId = player.get(ctx).first;
    final cardId = card.get(ctx).first;
    if (cardId.isEmpty) {
      final playerObject = ctx.state.player(identifier: playerId);
      return [
        GEventDiscardHand(
          player: playerId,
          card: playerObject.hand.randomElement().identifier,
        )
      ];
    } else {
      return [GEventDiscardInPlay(player: playerId, card: cardId)];
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
