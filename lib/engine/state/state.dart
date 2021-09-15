part 'card.dart';
part 'player.dart';
part 'hit.dart';
part 'move.dart';

class GState {
  final List<GPlayer> players;
  List<String> playOrder;
  String turn;
  int phase;
  List<GCard> deck;
  List<GCard> discard;
  List<GCard> store;
  GHit? hit;
  Role? winner;
  List<String> played;
  List<GMove> history;

  GState({
    required this.players,
    required this.playOrder,
    required this.turn,
    required this.phase,
    required this.deck,
    required this.discard,
    required this.store,
    required this.hit,
    required this.winner,
    required this.played,
    required this.history,
  });
}
