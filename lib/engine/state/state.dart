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
    this.players = const [],
    this.playOrder = const [],
    this.turn = '',
    this.phase = 0,
    this.deck = const [],
    this.discard = const [],
    this.store = const [],
    this.hit,
    this.winner,
    this.played = const [],
    this.history = const [],
  });

  GState.copy(GState state)
      : players = state.players.map((e) => GPlayer.copy(e)).toList(),
        playOrder = List.from(state.playOrder),
        turn = state.turn,
        phase = state.phase,
        deck = List.from(state.deck),
        discard = List.from(state.discard),
        store = List.from(state.store),
        hit = state.hit != null ? GHit.copy(state.hit!) : null,
        winner = state.winner,
        played = List.from(state.played),
        history = List.from(state.history);
}
