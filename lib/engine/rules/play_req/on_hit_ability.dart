part of 'play_req.dart';

/*
 When you are target of hit that requires ability X
 */
class OnHitAbility extends PlayReq {
  final String ability;

  OnHitAbility({required this.ability});

  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final event = ctx.event;
    return event is GEventSetHit &&
        event.hit.players.first == ctx.actor.identifier &&
        event.hit.abilities.contains(ability);
  }
}
