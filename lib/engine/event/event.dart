import '../state/state.dart';
part 'play.dart';
part 'equip.dart';
part 'handicap.dart';

abstract class GEvent {
  GState dispatch(GState state);
  Duration duration();
}
/*
// MARK: - draw card

class GEventDrawDeck extends GEvent {
  final String player;

  GEventDrawDeck({
    required this.player,
  });
}

class GEventDrawDeckFlipping extends GEvent {
  final String player;

  GEventDrawDeckFlipping({
    required this.player,
  });
}

class GEventDrawDeckChoosing extends GEvent {
  final String player;
  final String card;

  GEventDrawDeckChoosing({
    required this.player,
    required this.card,
  });
}

class GEventDrawHand extends GEvent {
  final String player;
  final String other;
  final String card;

  GEventDrawHand({
    required this.player,
    required this.other,
    required this.card,
  });
}

class GEventDrawInPlay extends GEvent {
  final String player;
  final String other;
  final String card;

  GEventDrawInPlay({
    required this.player,
    required this.other,
    required this.card,
  });
}

class GEventDrawStore extends GEvent {
  final String player;
  final String card;

  GEventDrawStore({
    required this.player,
    required this.card,
  });
}

class GEventDrawDiscard extends GEvent {
  final String player;

  GEventDrawDiscard({
    required this.player,
  });
}

// MARK: - discard card

class GEventDiscardHand extends GEvent {
  final String player;
  final String card;

  GEventDiscardHand({
    required this.player,
    required this.card,
  });
}

class GEventDiscardInPlay extends GEvent {
  final String player;
  final String card;

  GEventDiscardInPlay({
    required this.player,
    required this.card,
  });
}

class GEventPassInPlay extends GEvent {
  final String player;
  final String card;
  final String other;

  GEventPassInPlay({
    required this.player,
    required this.card,
    required this.other,
  });
}

class GEventDeckToStore extends GEvent {}

class GEventFlipDeck extends GEvent {}

// MARK: - flag changes

class GEventSetTurn extends GEvent {
  final String player;

  GEventSetTurn({
    required this.player,
  });
}

class GEventSetPhase extends GEvent {
  final String value;

  GEventSetPhase({
    required this.value,
  });
}

class GEventGameOver extends GEvent {
  final Role winner;

  GEventGameOver({
    required this.winner,
  });
}

// MARK: - player state

class GEventGainHealth extends GEvent {
  final String player;

  GEventGainHealth({
    required this.player,
  });
}

class GEventLooseHealth extends GEvent {
  final String player;

  GEventLooseHealth({
    required this.player,
  });
}

class GEventEliminate extends GEvent {
  final String player;

  GEventEliminate({
    required this.player,
  });
}

// MARK: - hit

class GEventAddHit extends GEvent {
  final GHit hit;

  GEventAddHit({
    required this.hit,
  });
}

class GEventRemoveHit extends GEvent {
  final String player;

  GEventRemoveHit({
    required this.player,
  });
}

class GEventDecrementHitCancelable extends GEvent {}

// MARK: - Engine events

class GEventActivate extends GEvent {
  final List<GMove> moves;

  GEventActivate({
    required this.moves,
  });
}

class GEventMove extends GEvent {
  final GMove move;

  GEventMove({
    required this.move,
  });
}

class GEventEmptyQueue extends GEvent {}
*/