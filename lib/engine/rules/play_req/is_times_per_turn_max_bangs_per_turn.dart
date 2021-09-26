part of 'play_req.dart';

/*
 May be played at most bangs per turn times during current turn
 */
class IsTimesPerTurnMaxBangsPerTurn extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final maxTimes = ctx.actor.currentBangsPerTurn();
    final unlimited = maxTimes == 0;
    if (unlimited) {
      return true;
    }
    return ctx.state.played.where((e) => e == ctx.ability).length < maxTimes;
  }
}
