part of 'effect.dart';

class DrawDeckFlippingIf extends Effect {
  final PlayerArgument player;
  final int amount;
  final String regex;
  final List<Effect> thenEffects;
  final List<Effect> elseEffects;

  DrawDeckFlippingIf.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!,
        amount = json['amount']!,
        regex = json['regex']!,
        thenEffects = Effect.fromJsonArray(json['then']),
        elseEffects = Effect.fromJsonArray(json['else'] ?? []);

  @override
  List<GEvent> apply(PlayContext ctx) {
    final List<GEvent> result = [];
    final playerId = player.get(ctx).first;
    for (var i = 0; i < amount; i++) {
      result.add(GEventDrawDeck(player: playerId));
    }
    result.add(GEventFlipHand(player: playerId));
    final cardObject = ctx.state.deck[amount - 1];
    final success = cardObject.matchesRegex(regex);
    final effects = success ? thenEffects : elseEffects;
    effects.forEach((e) {
      result.addAll(e.apply(ctx));
    });
    return result;
  }
}
