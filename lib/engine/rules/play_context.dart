import '../event/event.dart';
import '../state/state.dart';

class PlayContext {
  final String ability;
  final GPlayer actor;
  final GState state;
  final String? handCard;
  final String? inPlayCard;
  final GEvent? event;
  final PlayArgs? args;

  PlayContext({
    required this.ability,
    required this.actor,
    required this.state,
    this.handCard,
    this.inPlayCard,
    this.event,
    this.args,
  });
}

class PlayArgs {
  final List<String> requiredHand;
  final String? target;
  final String? requiredTargetCard;
  final String? requiredStore;
  final List<String> requiredDeck;

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
}
