part of '../effect.dart';

enum NumberArgument {
  one,
  three,
  bangsPerTurn,
  inPlayPlayers,
  excessHand,
  damage,
  weapon,
}

extension GettingValue on NumberArgument {
  int get(PlayContext ctx) {
    switch (this) {
      case NumberArgument.one:
        return 1;

      case NumberArgument.three:
        return 3;

      case NumberArgument.excessHand:
        return max(ctx.actor.hand.length - ctx.actor.maxHand(), 0);

      case NumberArgument.inPlayPlayers:
        return ctx.state.playOrder.length;

      default:
        throw Exception('Unimplemented argument: $this');
    }
  }
}
