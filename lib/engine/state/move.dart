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
  final String? requiredStore;
  final List<String> requiredDeck;

  const PlayArgs({
    this.requiredHand = const [],
    this.target,
    this.requiredInPlay,
    this.requiredStore,
    this.requiredDeck = const [],
  });

  PlayArgs copyWith(
      {List<String>? requiredHand,
      String? target,
      String? requiredInPlay,
      String? requiredStore,
      List<String>? requiredDeck}) {
    return PlayArgs(
      requiredHand: requiredHand ?? this.requiredHand,
      target: target ?? this.target,
      requiredInPlay: requiredInPlay ?? this.requiredInPlay,
      requiredStore: requiredStore ?? this.requiredStore,
      requiredDeck: requiredDeck ?? this.requiredDeck,
    );
  }
}
