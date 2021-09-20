part of 'play_req.dart';

/*
 * Set target the value of hit.target
 */
class RequireTargetHit extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final target = ctx.state.hit?.targets.first;
    if (target == null) {
      return false;
    }
    return args.appendTarget([target]);
  }
}
