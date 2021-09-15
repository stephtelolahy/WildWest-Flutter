part of 'state.dart';

class GMove {
  final String ability;
  final String actor;
  final String card;
  final Map<PlayArg, dynamic> args;

  GMove({
    required this.ability,
    required this.actor,
    required this.card,
    required this.args,
  });
}

enum PlayArg {
  requiredHand,
  target,
  requiredInPlay,
  requiredStore,
  requiredDeck,
}
