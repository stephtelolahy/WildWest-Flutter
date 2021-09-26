part of 'state.dart';

class GMove extends Equatable {
  final String ability;
  final String actor;
  final String? handCard; // played hand card
  final String? inPlayCard; // played inPlay card
  final List<String> requiredHand; // actor's hand card
  final String? target; // target player
  final String? requiredTargetCard; // target's card ('' for randomHand)
  final String? requiredStore; // store card
  final List<String> requiredDeck; // deck card

  GMove({
    required this.ability,
    required this.actor,
    this.handCard,
    this.inPlayCard,
    this.requiredHand = const [],
    this.target,
    this.requiredTargetCard,
    this.requiredStore,
    this.requiredDeck = const [],
  });

  @override
  List<Object?> get props => [
        ability,
        actor,
        handCard,
        inPlayCard,
        requiredHand,
        target,
        requiredTargetCard,
        requiredStore,
        requiredDeck,
      ];
}
