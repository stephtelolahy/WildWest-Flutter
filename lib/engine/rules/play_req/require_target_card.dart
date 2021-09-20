part of 'play_req.dart';

class RequireTargetCard extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    return args.appendRequiredTargetCard(ctx.state);
  }
}
