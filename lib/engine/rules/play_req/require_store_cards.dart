part of 'play_req.dart';

/*
Must choose choose X cards from store
*/
class RequireStoreCards extends PlayReq {
  final int amount;

  RequireStoreCards({required this.amount});

  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final cards = ctx.state.store.map((e) => e.identifier);
    return PlayReqUtils.appendRequiredStore(cards, args);
  }
}
