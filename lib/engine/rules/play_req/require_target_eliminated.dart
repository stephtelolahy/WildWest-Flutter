part of 'play_req.dart';

/*
 Set target the player that just is eliminated
 */
class RequireTargetEliminated extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final event = ctx.event;
    if (event is GEventEliminate && event.player != ctx.actor.identifier) {
      return PlayReqUtils.appendTarget([event.player], args);
    } else {
      return false;
    }
  }
}
