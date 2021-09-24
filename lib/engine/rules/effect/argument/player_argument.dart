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

      case PlayerArgument.others:
        return ctx.state.playOrder.startingWith(ctx.actor.identifier).sublist(1);

      case PlayerArgument.next:
        final actorId = ctx.actor.identifier;
        final players =
            ctx.state.players.map((e) => e.identifier).toList().startingWith(actorId).skip(1);
        final next = players.firstWhere((e) => e != actorId && ctx.state.playOrder.contains(e));
        return [next];

      default:
        throw Exception('Unimplemented argument: $this');
    }
  }
}

extension Rotating<T> on List<T> {
  List<T> startingWith(T element) {
    final index = this.indexOf(element);
    return this.sublist(index)..addAll(this.sublist(0, index));
  }
}
