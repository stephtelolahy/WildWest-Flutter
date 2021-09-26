part of 'effect.dart';

/*
 * Put a hand card in other's inPlay
 - RULE: cannot have two copies of the same card in play
 */
class Handicap extends Effect {
  final PlayerArgument player;
  final CardArgument card;
  final PlayerArgument other;

  Handicap.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!,
        card = EnumToString.fromString(CardArgument.values, json['card'])!,
        other = EnumToString.fromString(PlayerArgument.values, json['other'])!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final playerId = player.get(ctx).first;
    final cardId = card.get(ctx).first;
    final otherId = other.get(ctx).first;

    // <RULE> cannot have two copies of the same card in play
    final playerObject = ctx.state.player(id: playerId);
    final cardObject = playerObject.hand.firstWhere((e) => e.id == cardId);
    final otherObject = ctx.state.player(id: otherId);
    if (otherObject.inPlay.any((e) => e.name.isNotEmpty && e.name == cardObject.name)) {
      return [];
    }
    // </RULE>

    return [GEventHandicap(player: playerId, card: cardId, other: otherId)];
  }
}
