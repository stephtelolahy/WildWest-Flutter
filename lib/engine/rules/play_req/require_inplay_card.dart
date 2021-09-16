part of 'play_req.dart';

/*
Must choose any card in play of targeted
*/
class RequireInPlayCard extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    return PlayReqUtils.appendRequiredInPlay(ctx.state, args);
  }
}
