part of 'play_req.dart';

/*
Must choose choose a card from store
*/
class RequireStoreCard extends PlayReq {
  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final cards = ctx.state.store.map((e) => e.identifier);
    return args.appendRequiredStore(cards);
  }
}
