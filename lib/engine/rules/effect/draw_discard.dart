part of 'effect.dart';

class DrawDiscard extends Effect {
  final PlayerArgument player;

  DrawDiscard.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final playerId = player.get(ctx).first;
    if (ctx.state.discard.isEmpty) {
      return [];
    }
    return [GEventDrawDiscard(player: playerId)];
  }
}
