part of 'play_req.dart';

/*
 When having more cards than hand limit
 */
class IsHandExceedLimit extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    return ctx.actor.hand.length > PlayReqUtils.handLimit(ctx.actor);
  }
}
