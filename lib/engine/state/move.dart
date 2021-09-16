part of 'state.dart';

class GMove {
  final String ability;
  final String actor;
  final String? card;
  final PlayArgs args;

  GMove({
    required this.ability,
    required this.actor,
    this.card,
    this.args = const PlayArgs(),
  });
}

class PlayArgs {
  final List<String> requiredHand;
  final String? target;
  final String? requiredInPlay;
  final List<String> requiredStore;
  final List<String> requiredDeck;

  const PlayArgs({
    this.requiredHand = const [],
    this.target,
    this.requiredInPlay,
    this.requiredStore = const [],
    this.requiredDeck = const [],
  });
}
