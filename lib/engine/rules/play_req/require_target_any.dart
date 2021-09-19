part of 'play_req.dart';

/*
 Must target any player
 */
class RequireTargetAny extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    return args.appendTarget(ctx.state.playOrder);
  }
}
