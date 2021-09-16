part of 'play_req.dart';

/*
 May be played at most X times during current turn
 */
class IsTimesPerTurnMax extends PlayReq {
  final int maxTimes;

  IsTimesPerTurnMax({required this.maxTimes});

  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    return ctx.state.played.where((e) => e == ctx.ability).length < maxTimes;
  }
}
