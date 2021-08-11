import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState.initial());

  List<String> deck = [
    "barrel",
    "dynamite",
    "mustang",
    "gatling",
    "stagecoach",
    "indians"
  ];

  void draw() {
    var hand = state.hand;
    if (deck.isNotEmpty) {
      hand.add(deck.removeAt(0));
      emit(GameState(discard: state.discard, hand: hand));
    }
  }

  void play(String card) {
    var hand = state.hand;
    hand.remove(card);
    emit(GameState(discard: card, hand: hand));
  }
}
