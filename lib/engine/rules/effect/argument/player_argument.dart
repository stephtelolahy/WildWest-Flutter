part of '../effect.dart';

enum PlayerArgument {
  actor,
  target,
  all,
  next,
  others,
  nobody,
  othersWithCard,
}

extension GettingPlayers on PlayerArgument {
  List<String> get(PlayContext ctx) {
    switch (this) {
      case PlayerArgument.actor:
        return [ctx.actor.identifier];

      case PlayerArgument.target:
        return [ctx.args!.target!];

      default:
        throw Exception('Unimplemented argument: $this');
    }
  }
}
