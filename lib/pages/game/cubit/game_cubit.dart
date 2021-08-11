import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState.initial());

  void draw() {
    var deck = state.deck;
    var hand = state.hand;
    if (deck.isNotEmpty) {
      hand.add(deck.removeAt(0));
      emit(GameState(deck: deck, discard: state.discard, hand: hand));
    }
  }
}
