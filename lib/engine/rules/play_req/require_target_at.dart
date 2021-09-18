part of 'play_req.dart';

/*
 Must target any other player at distance of X
 */
class RequireTargetAt extends PlayReq {
  final int distance;

  RequireTargetAt({required this.distance});

  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final others = ctx.state.playOrder.where((e) =>
        e != ctx.actor.identifier &&
        PlayReqUtils.distance(from: ctx.actor.identifier, to: e, state: ctx.state) <= distance);
    return PlayReqUtils.appendTarget(others, args);
  }
}
