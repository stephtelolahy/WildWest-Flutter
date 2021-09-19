part of 'effect.dart';

/*
 Loose life point
 */
class LooseHealth extends Effect {
  final PlayerArgument player;

  LooseHealth.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final playerId = player.get(ctx).first;
    final playerObject = ctx.state.player(identifier: playerId);
    if (playerObject.health > 1) {
      return [GEventLooseHealth(player: playerId)];
    } else {
      return [GEventEliminate(player: playerId)];
    }
  }
}
