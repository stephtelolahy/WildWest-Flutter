part of 'play_req.dart';

/*
 Must target any other player
 */
class RequireTargetOther extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final others = ctx.state.playOrder.where((e) => e != ctx.actor.id);
    return args.appendTarget(others);
  }
}
