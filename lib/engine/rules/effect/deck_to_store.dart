part of 'effect.dart';

class DeckToStore extends Effect {
  final NumberArgument amount;

  DeckToStore.fromJson(Map<String, dynamic> json)
      : amount = EnumToString.fromString(NumberArgument.values, json['amount']!)!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final count = amount.get(ctx);
    return List<GEvent>.generate(count, (_) => GEventDeckToStore());
  }
}
