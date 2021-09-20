part of 'state.dart';

class GMove extends Equatable {
  final String ability;
  final String actor;
  final String? handCard;
  final String? inPlayCard;
  final PlayArgs? args;

  GMove({
    required this.ability,
    required this.actor,
    this.handCard,
    this.inPlayCard,
    this.args,
  });

  @override
  List<Object?> get props => [ability, actor, handCard, inPlayCard, args];
}

class PlayArgs extends Equatable {
  final List<String> requiredHand; // actor's hand card
  final String? target; // target player
  final String? requiredTargetCard; // target's card ('' for randomHand)
  final String? requiredStore; // store card
  final List<String> requiredDeck; // deck card

  const PlayArgs({
    this.requiredHand = const [],
    this.target,
    this.requiredTargetCard,
    this.requiredStore,
    this.requiredDeck = const [],
  });

  PlayArgs copyWith(
      {List<String>? requiredHand,
      String? target,
      String? requiredTargetCard,
      String? requiredStore,
      List<String>? requiredDeck}) {
    return PlayArgs(
      requiredHand: requiredHand ?? this.requiredHand,
      target: target ?? this.target,
      requiredTargetCard: requiredTargetCard ?? this.requiredTargetCard,
      requiredStore: requiredStore ?? this.requiredStore,
      requiredDeck: requiredDeck ?? this.requiredDeck,
    );
  }

  @override
  List<Object?> get props =>
      [requiredHand, target, requiredTargetCard, requiredStore, requiredDeck];
}
