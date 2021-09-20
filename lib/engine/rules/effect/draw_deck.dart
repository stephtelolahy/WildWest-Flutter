part of 'effect.dart';

class DrawDeck extends Effect {
  final PlayerArgument player;
  final int amount;

  DrawDeck.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!,
        amount = json['amount'] ?? 1;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final List<GEvent> result = [];
    final players = player.get(ctx);
    for (var p in players) {
      for (var i = 0; i < amount; i++) {
        result.add(GEventDrawDeck(player: p));
      }
    }

    return result;
  }
}
