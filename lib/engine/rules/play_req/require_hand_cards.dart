part of 'play_req.dart';

/*
Must choose X cards from your hand
*/
class RequireHandCards extends PlayReq {
  final int amount;

  RequireHandCards({required this.amount});

  @override
  bool match(PlayContext ctx, List<PlayArgs> args) {
    final values = ctx.actor.hand.map((e) => e.identifier).where((e) => e != ctx.handCard);
    return args.appendRequiredHand(values, amount);
  }
}
