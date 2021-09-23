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
    final cardIds = card.get(ctx, player: playerId);
    final playerObject = ctx.state.player(identifier: playerId);
    return cardIds.map((card) {
      if (playerObject.hand.any((e) => e.identifier == card)) {
        return GEventDiscardHand(player: playerId, card: card);
      } else {
        return GEventDiscardInPlay(player: playerId, card: card);
      }
    }).toList();
  }
}
