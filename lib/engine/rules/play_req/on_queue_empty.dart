part of 'play_req.dart';

/*
 When events queue is empty
 */

class OnQueueEmpty extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final event = ctx.event;
    return event is GEventIdle;
  }
}
