part of 'effect.dart';

/*
 Remove player from hit
 */
class RemoveHit extends Effect {
  final PlayerArgument player;

  RemoveHit.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final playerId = player.get(ctx).first;
    return [GEventRemoveHit(player: playerId)];
  }
}
