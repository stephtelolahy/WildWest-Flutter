part of 'play_req.dart';

/*
 Must be your turn
 */
class IsYourTurn extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    return ctx.state.turn == ctx.actor.id;
  }
}
