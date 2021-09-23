part of 'effect.dart';

class DrawPlayer extends Effect {
  final PlayerArgument player;
  final PlayerArgument other;
  final CardArgument card;

  DrawPlayer.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!,
        other = EnumToString.fromString(PlayerArgument.values, json['other']!)!,
        card = EnumToString.fromString(CardArgument.values, json['card']!)!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final playerId = player.get(ctx).first;
    final otherId = other.get(ctx).first;
    final cardIds = card.get(ctx, player: otherId);
    final otherObject = ctx.state.player(identifier: otherId);
    return cardIds.map((card) {
      if (otherObject.hand.any((e) => e.identifier == card)) {
        return GEventDrawHand(player: playerId, other: otherId, card: card);
      } else {
        return GEventDrawInPlay(player: playerId, other: otherId, card: card);
      }
    }).toList();
  }
}
