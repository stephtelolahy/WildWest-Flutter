part of 'play_req.dart';

/*
 Your health must be equal to X
 */
class IsHealth extends PlayReq {
  final int health;

  IsHealth({required this.health});

  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    return ctx.actor.health == health;
  }
}
