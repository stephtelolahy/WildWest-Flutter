part of 'play_req.dart';

/*
 Must target any other player at reachable distance
 */
class RequireTargetReachable extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final weapon = ctx.actor.weapon();
    final others = ctx.state.playOrder.where((e) =>
        e != ctx.actor.identifier &&
        ctx.state.distance(from: ctx.actor.identifier, to: e) <= weapon);
    return args.appendTarget(others);
  }
}
