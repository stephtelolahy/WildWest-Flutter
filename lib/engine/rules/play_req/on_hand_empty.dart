part of 'play_req.dart';

/*
 When your hand is empty
 */

class OnHandEmpty extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final event = ctx.event;

    if (event is GEventPlay && event.player == ctx.actor.identifier && ctx.actor.hand.isEmpty) {
      return true;
    }

    if (event is GEventEquip && event.player == ctx.actor.identifier && ctx.actor.hand.isEmpty) {
      return true;
    }

    if (event is GEventHandicap && event.player == ctx.actor.identifier && ctx.actor.hand.isEmpty) {
      return true;
    }

    if (event is GEventDiscardHand &&
        event.player == ctx.actor.identifier &&
        ctx.actor.hand.isEmpty) {
      return true;
    }

    if (event is GEventDrawHand && event.other == ctx.actor.identifier && ctx.actor.hand.isEmpty) {
      return true;
    }

    return false;
  }
}
