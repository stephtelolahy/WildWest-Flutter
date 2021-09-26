part of 'effect.dart';

class DrawDeckChoosing extends Effect {
  final PlayerArgument player;
  final CardArgument card;

  DrawDeckChoosing.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!,
        card = EnumToString.fromString(CardArgument.values, json['card']!)!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final List<GEvent> result = [];
    final players = player.get(ctx);
    final cards = card.get(ctx);
    for (var p in players) {
      for (var card in cards) {
        result.add(GEventDrawDeckCard(player: p, card: card));
      }
    }

    return result;
  }
}
