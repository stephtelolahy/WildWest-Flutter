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

      case PlayerArgument.all:
        return ctx.state.playOrder.startingWith(ctx.actor.identifier);

      default:
        throw Exception('Unimplemented argument: $this');
    }
  }
}

extension Rotating on List<String> {
  List<String> startingWith(String element) {
    final index = this.indexOf(element);
    return this.sublist(index)..addAll(this.sublist(0, index));
  }
}
