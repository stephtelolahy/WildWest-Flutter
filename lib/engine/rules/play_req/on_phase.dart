part of 'play_req.dart';

/*
 When phase changed to X
 */
class OnPhase extends PlayReq {
  final int phase;

  OnPhase({required this.phase});

  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final event = ctx.event;
    return event is GEventSetPhase && event.phase == phase;
  }
}
