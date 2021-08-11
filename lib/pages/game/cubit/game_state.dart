part of 'game_cubit.dart';

@immutable
class GameState {
  final List<String> deck;
  final List<String> discard;
  final List<String> hand;

  GameState({required this.deck, required this.discard, required this.hand});

  GameState.initial()
      : this.deck = [
          "bang",
          "missed",
          "panic",
          "tequila",
          "mustang",
          "panic",
          "jail",
        ],
        this.discard = [],
        this.hand = [
          "volcanic",
          "missed",
        ];
}
