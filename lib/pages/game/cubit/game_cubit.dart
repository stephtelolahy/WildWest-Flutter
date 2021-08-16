import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit()
      : super(GameState(
            others: List.generate(6, (index) => 'player $index'),
            played: null,
            discard: [],
            hand: [],
            event: null));

  int _counter = 0;
  String _getDeckCard() {
    _counter++;
    return "card $_counter";
  }

  void update() {
    final event = state.event;
    if (event is GameEventDraw) {
      emit(GameState(
          others: state.others,
          played: state.played,
          discard: state.discard,
          hand: state.hand + [event.card],
          event: null));
    }
  }

  void play(String card) {
    final hand = state.hand..remove(card);

    final discard = state.discard;
    final played = state.played;
    if (played != null) {
      discard.add(played);
    }

    emit(GameState(
      others: state.others,
      played: card,
      discard: discard,
      hand: hand,
      event: GameEventPlay(),
    ));
  }

  void draw() {
    emit(
      GameState(
        others: state.others,
        played: state.played,
        discard: state.discard,
        hand: state.hand,
        event: GameEventDraw(card: _getDeckCard()),
      ),
    );
  }
}
