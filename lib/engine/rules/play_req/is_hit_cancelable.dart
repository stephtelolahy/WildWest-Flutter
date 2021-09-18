part of 'play_req.dart';

/*
 Must be target of hit that is cancelable
 */
class IsHitCancelable extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final hit = ctx.state.hit;
    return hit != null && hit.players.first == ctx.actor.identifier && hit.cancelable > 0;
  }
}
