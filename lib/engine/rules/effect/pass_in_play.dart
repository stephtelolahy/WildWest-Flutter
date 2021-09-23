part of 'effect.dart';

class PassInPlay extends Effect {
  final PlayerArgument player;
  final CardArgument card;
  final PlayerArgument other;

  PassInPlay.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!,
        card = EnumToString.fromString(CardArgument.values, json['card']!)!,
        other = EnumToString.fromString(PlayerArgument.values, json['other']!)!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final playerId = player.get(ctx).first;
    final cardId = card.get(ctx, player: playerId).first;
    final otherId = other.get(ctx).first;
    return [GEventPassInPlay(player: playerId, card: cardId, other: otherId)];
  }
}
