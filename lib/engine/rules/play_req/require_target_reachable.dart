part of 'play_req.dart';

/*
 Must target any other player at reachable distance
 */
class RequireTargetReachable extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final weapon = PlayReqUtils.weapon(ctx.actor);
    final others = ctx.state.playOrder.where((e) =>
        e != ctx.actor.identifier &&
        PlayReqUtils.distance(from: ctx.actor.identifier, to: e, state: ctx.state) <= weapon);
    return PlayReqUtils.appendTarget(others, args);
  }
}
