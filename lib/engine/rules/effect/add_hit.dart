part of 'effect.dart';

class AddHit extends Effect {
  final PlayerArgument player;
  final List<String> abilities;
  final PlayerArgument target;
  final NumberArgument times;

  AddHit.fromJson(Map<String, dynamic> json)
      : player = EnumToString.fromString(PlayerArgument.values, json['player'] ?? 'actor')!,
        target = EnumToString.fromString(PlayerArgument.values, json['target'] ?? 'nobody')!,
        abilities = List<String>.from(json['abilities']!),
        times = EnumToString.fromString(NumberArgument.values, json['times'] ?? 'one')!;

  @override
  List<GEvent> apply(PlayContext ctx) {
    final List<GEvent> result = [];
    final playerIds = player.get(ctx);
    final loop = times.get(ctx);

    final List<String> playerArray = [];
    final List<String> targetArray = [];

    for (var i = 0; i < loop; i++) {
      for (var p in playerIds) {
        if (target == PlayerArgument.nobody) {
          playerArray.add(p);
        } else {
          final targetIds = target.get(ctx);
          for (var t in targetIds) {
            targetArray.add(t);
            playerArray.add(p);
          }
        }
      }
    }

    return [
      GEventSetHit(
          hit: GHit(
        name: ctx.ability,
        players: playerArray,
        abilities: abilities,
        targets: targetArray,
      ))
    ];
  }
}
