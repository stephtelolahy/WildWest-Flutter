part of 'play_req.dart';

/*
 Must target any other player at reachable distance
 */
class RequireTargetReachable extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final weapon = ctx.actor.currentWeapon();
    final others = ctx.state.playOrder
        .where((e) => e != ctx.actor.id && ctx.state.distance(from: ctx.actor.id, to: e) <= weapon);
    return args.appendTarget(others);
  }
}
