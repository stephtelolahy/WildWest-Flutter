part of 'play_req.dart';

/*
 Must be first to resolve hit named X
 */
class IsHitName extends PlayReq {
  final String hitName;

  IsHitName({required this.hitName});

  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final hit = ctx.state.hit;
    return hit != null && hit.players.first == ctx.actor.id && hit.name == hitName;
  }
}
