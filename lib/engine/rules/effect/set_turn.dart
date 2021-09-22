part of 'effect.dart';

/*
 Set turn X
 */
class SetTurn extends Effect {
  final PlayerArgument player;

  SetTurn.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player']!)!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final playerId = player.get(ctx).first;
    return [GEventSetTurn(player: playerId)];
  }
}
