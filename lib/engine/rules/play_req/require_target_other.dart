part of 'play_req.dart';

class RequireTargetOther extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final others = ctx.state.playOrder.where((e) => e != ctx.actor.identifier).toList();
    others.forEach((e) {
      args.add(PlayArgs(target: e));
    });
    return true;
  }
}
