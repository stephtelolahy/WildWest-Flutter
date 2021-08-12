import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit()
      : super(GameState(
            others: List.generate(6, (index) => 'player $index'),
            played: null,
            discard: [],
            hand: []));

  int _counter = 0;
  String _getDeckCard() {
    _counter++;
    return "card $_counter";
  }

  void draw() {
    emit(GameState(
      others: state.others,
      played: state.played,
      discard: state.discard,
      hand: state.hand + [_getDeckCard()],
    ));
  }

  void play(String card) {
    var hand = state.hand;
    hand.remove(card);

    var discard = state.discard;
    final played = state.played;
    if (played != null) {
      discard.add(played);
    }

    emit(GameState(
      others: state.others,
      played: card,
      discard: discard,
      hand: hand,
    ));
  }
}
