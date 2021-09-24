part of 'effect.dart';

class FlipDeckIf extends Effect {
  final String regex;
  final List<Effect> thenEffects;
  final List<Effect> elseEffects;

  FlipDeckIf.fromJson(Map<String, dynamic> json)
      : regex = json['regex']!,
        thenEffects = Effect.fromJsonArray(json['then']),
        elseEffects = Effect.fromJsonArray(json['else'] ?? []);

  @override
  List<GEvent> apply(PlayContext ctx) {
    final List<GEvent> result = [];
    final amount = ctx.actor.flippedCards();
    for (var i = 0; i < amount; i++) {
      result.add(GEventFlipDeck());
    }
    final cards = ctx.state.deck.sublist(0, amount);
    final success = cards.any((e) => e.matchesRegex(regex));
    final effects = success ? thenEffects : elseEffects;
    effects.forEach((e) {
      result.addAll(e.apply(ctx));
    });
    return result;
  }
}
