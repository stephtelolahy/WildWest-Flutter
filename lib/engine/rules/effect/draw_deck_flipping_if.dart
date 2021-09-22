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
    return [];
  }
}
