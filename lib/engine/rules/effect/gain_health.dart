part of 'effect.dart';

/*
 Gain life point respecting health limit
 - RULE: cannot have more health than maxHealth
 */
class GainHealth extends Effect {
  final PlayerArgument player;
  final int amount;

  GainHealth.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!,
        amount = json['amount'] ?? 1;

  @override
  List<GEvent> apply(PlayContext ctx) {
    List<GEvent> result = [];
    final players = player.get(ctx);
    for (var p in players) {
      // <RULE> cannot have more health than maxHealth
      final playerObject = ctx.state.player(identifier: p);
      final gain = min(amount, EffectUtils.maxHealth(playerObject) - playerObject.health);
      if (gain <= 0) {
        continue;
      }
      // </RULE>

      for (var i = 0; i < gain; i++) {
        result.add(GEventGainHealth(player: p));
      }
    }

    return result;
  }
}
