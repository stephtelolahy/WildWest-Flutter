part of 'effect.dart';

class ReverseHit extends Effect {
  final PlayerArgument player;

  ReverseHit.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final playerId = player.get(ctx).first;
    return [GEventReverseHit(player: playerId)];
  }
}
