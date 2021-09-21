part of 'play_req.dart';

/*
 When you eliminated a player with role X
 */

class OnEliminatingRole extends PlayReq {
  final Role role;

  OnEliminatingRole({required this.role});

  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final event = ctx.event;
    return event is GEventEliminate &&
        ctx.state.player(identifier: event.player).role == role &&
        event.player != ctx.actor.identifier &&
        ctx.actor.identifier == ctx.state.turn;
  }
}
