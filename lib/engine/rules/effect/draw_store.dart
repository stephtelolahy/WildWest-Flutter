part of 'effect.dart';

class DrawStore extends Effect {
  final PlayerArgument player;
  final CardArgument card;

  DrawStore.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!,
        card = EnumToString.fromString(CardArgument.values, json['card']!)!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final playerId = player.get(ctx).first;
    final cardId = card.get(ctx).first;
    return [GEventDrawStore(player: playerId, card: cardId)];
  }
}
