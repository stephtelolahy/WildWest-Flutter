part of 'effect.dart';

/*
Put a hand card in self inPlay
 - RULE: cannot have two copies of the same card in play
 - RULE: discard previous weapon if playing new one
*/

class Equip extends Effect {
  final PlayerArgument player;
  final CardArgument card;

  Equip.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!,
        card = EnumToString.fromString(CardArgument.values, json['card'])!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final playerId = player.get(ctx).first;
    final cardId = card.get(ctx).first;

    // <RULE> cannot have two copies of the same card in play
    final playerObject = ctx.state.player(identifier: playerId);
    final cardObject = playerObject.hand.firstWhere((e) => e.identifier == cardId);
    if (playerObject.inPlay.any((e) => e.name.isNotEmpty && e.name == cardObject.name)) {
      return [];
    }
    // </RULE>

    List<GEvent> result = [GEventEquip(player: playerId, card: cardId)];

    // <RULE> discard previous weapon if playing new one
    if (cardObject.weapon != null && playerObject.inPlay.any((e) => e.weapon != null)) {
      final previousWeapon = playerObject.inPlay.firstWhere((e) => e.weapon != null);
      result.add(GEventDiscardInPlay(player: playerId, card: previousWeapon.identifier));
    }
    // </RULE>

    return result;
  }
}
