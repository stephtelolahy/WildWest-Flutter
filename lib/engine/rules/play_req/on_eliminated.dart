part of 'play_req.dart';

/*
 When you loose your last health
 */
class OnEliminated extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final event = ctx.event;
    return event is GEventEliminate && event.player == ctx.actor.id;
  }
}
