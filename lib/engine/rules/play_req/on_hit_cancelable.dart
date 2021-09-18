part of 'play_req.dart';

/*
 When you are target of hit that is cancelable with a 'missed' card
 */
class OnHitCancelable extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final event = ctx.event;
    return event is GEventSetHit &&
        event.hit.players.contains(ctx.actor.identifier) &&
        event.hit.cancelable > 0;
  }
}
