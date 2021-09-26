import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

part 'card.dart';
part 'hit.dart';
part 'player.dart';

class GState {
  final List<GPlayer> players;
  final List<String> playOrder;
  String turn;
  int phase;
  final List<GCard> deck;
  final List<GCard> discard; // discard pile, only last element is visible to users
  final List<GCard> store;
  final List<String> played;
  GHit? hit;
  Role? winner;

  GState({
    this.players = const [],
    this.playOrder = const [],
    this.turn = '',
    this.phase = 0,
    this.deck = const [],
    this.discard = const [],
    this.store = const [],
    this.played = const [],
    this.hit,
    this.winner,
  });

  GState.copy(GState state)
      : players = state.players.map((e) => GPlayer.copy(e)).toList(),
        playOrder = List.from(state.playOrder),
        turn = state.turn,
        phase = state.phase,
        deck = List.from(state.deck),
        discard = List.from(state.discard),
        store = List.from(state.store),
        played = List.from(state.played),
        hit = state.hit != null ? GHit.copy(state.hit!) : null,
        winner = state.winner;
}

extension GettingPlayer on GState {
  GPlayer player({id: String}) => players.firstWhere((e) => e.id == id);
}
