part of 'play_req.dart';

/*
Must choose X cards among (X + 1) top deck
*/
class RequireDeckCards extends PlayReq {
  final int amount;

  RequireDeckCards({required this.amount});

  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final values = ctx.state.deck.sublist(0, 2).map((e) => e.identifier);
    return PlayReqUtils.appendRequiredDeck(values, amount, args);
  }
}
