part of 'play_req.dart';

/*
 Must be target of hit that requires ability X
 */
class IsHitEffect extends PlayReq {
  final String ability;

  IsHitEffect({required this.ability});

  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final hit = ctx.state.hit;
    return hit != null &&
        hit.players.first == ctx.actor.identifier &&
        hit.abilities.contains(ability);
  }
}
