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
        return [ctx.actor.id];

      case PlayerArgument.target:
        return [ctx.args!.target!];

      case PlayerArgument.all:
        return ctx.state.playOrder.startingWith(ctx.actor.id);

      case PlayerArgument.others:
        return ctx.state.playOrder.startingWith(ctx.actor.id).sublist(1);

      case PlayerArgument.next:
        final actorId = ctx.actor.id;
        final players = ctx.state.players.map((e) => e.id).toList().startingWith(actorId).skip(1);
        final next = players.firstWhere((e) => e != actorId && ctx.state.playOrder.contains(e));
        return [next];

      default:
        throw Exception('Unimplemented argument: $this');
    }
  }
}
