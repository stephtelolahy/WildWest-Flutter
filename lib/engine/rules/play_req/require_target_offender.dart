part of 'play_req.dart';

/*
 Set target the player that just damaged you (obviously current turn player)
 */
class RequireTargetOffender extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final event = ctx.event;
    if (event is GEventLooseHealth &&
        event.player == ctx.actor.id &&
        ctx.state.turn != ctx.actor.id) {
      return args.appendTarget([ctx.state.turn]);
    } else {
      return false;
    }
  }
}
