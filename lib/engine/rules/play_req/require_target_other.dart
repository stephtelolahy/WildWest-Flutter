part of 'play_req.dart';

class RequireTargetOther extends PlayReq {
  @override
  bool match(PlayContext ctx, List<Map<PlayArg, dynamic>> args) {
    final others = ctx.state.playOrder.where((e) => e != ctx.actor.identifier).toList();
    args.add({PlayArg.target: others});
    return true;
  }
}
