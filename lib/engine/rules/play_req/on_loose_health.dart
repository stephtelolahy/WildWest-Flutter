part of 'play_req.dart';

/*
 When you loose health but not eliminated
 */
class OnLooseHealth extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final event = ctx.event;
    return event is GEventLooseHealth && event.player == ctx.actor.id;
  }
}
