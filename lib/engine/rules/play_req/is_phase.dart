part of 'play_req.dart';

/*
 Must be on phase X and no playing hit
 */
class IsPhase extends PlayReq {
  final int phase;

  IsPhase({required this.phase});

  @override
  bool match(PlayContext ctx, List<Map<PlayArg, dynamic>> args) {
    return ctx.state.phase == phase && ctx.state.hit == null;
  }
}
