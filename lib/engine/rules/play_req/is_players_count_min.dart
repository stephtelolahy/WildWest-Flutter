part of 'play_req.dart';

/*
 The minimum number of in play players is X
 */
class IsPlayersCountMin extends PlayReq {
  final int minPlayersCount;

  IsPlayersCountMin({required this.minPlayersCount});

  @override
  bool match(PlayContext ctx, List<Map<PlayArg, dynamic>> args) {
    return ctx.state.playOrder.length >= minPlayersCount;
  }
}
