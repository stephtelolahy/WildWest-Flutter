import 'package:equatable/equatable.dart';

import '../state/state.dart';

part 'equip.dart';
part 'handicap.dart';
part 'play.dart';

abstract class GEvent extends Equatable {
  GState dispatch(GState state);
  Duration duration();

  static const DEFAULT_DURATION = Duration(milliseconds: 400);
}

// MARK: - draw card

class GEventDrawDeck extends GEvent {
  final String player;

  GEventDrawDeck({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventDrawDeckFlipping extends GEvent {
  final String player;

  GEventDrawDeckFlipping({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventDrawDeckChoosing extends GEvent {
  final String player;
  final String card;

  GEventDrawDeckChoosing({
    required this.player,
    required this.card,
  });

  @override
  List<Object?> get props => [player, card];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
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

  @override
  List<Object?> get props => [player, other, card];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
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

  @override
  List<Object?> get props => [player, card];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventDrawStore extends GEvent {
  final String player;
  final String card;

  GEventDrawStore({
    required this.player,
    required this.card,
  });

  @override
  List<Object?> get props => [player, card];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventDrawDiscard extends GEvent {
  final String player;

  GEventDrawDiscard({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

// MARK: - discard card

class GEventDiscardHand extends GEvent {
  final String player;
  final String card;

  GEventDiscardHand({
    required this.player,
    required this.card,
  });

  @override
  List<Object?> get props => [player, card];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventDiscardInPlay extends GEvent {
  final String player;
  final String card;

  GEventDiscardInPlay({
    required this.player,
    required this.card,
  });

  @override
  List<Object?> get props => [player, card];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
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

  @override
  List<Object?> get props => [player, card, other];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventDeckToStore extends GEvent {
  @override
  List<Object?> get props => [];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventFlipDeck extends GEvent {
  @override
  List<Object?> get props => [];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

// MARK: - flag changes

class GEventSetTurn extends GEvent {
  final String player;

  @override
  List<Object?> get props => [player];

  GEventSetTurn({
    required this.player,
  });

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventSetPhase extends GEvent {
  final int phase;

  @override
  List<Object?> get props => [phase];

  GEventSetPhase({
    required this.phase,
  });

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventGameOver extends GEvent {
  final Role winner;

  @override
  List<Object?> get props => [winner];

  GEventGameOver({
    required this.winner,
  });

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

// MARK: - player state

class GEventGainHealth extends GEvent {
  final String player;

  @override
  List<Object?> get props => [player];

  GEventGainHealth({
    required this.player,
  });

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventLooseHealth extends GEvent {
  final String player;

  GEventLooseHealth({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventEliminate extends GEvent {
  final String player;

  GEventEliminate({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

// MARK: - hit

class GEventAddHit extends GEvent {
  final GHit hit;

  GEventAddHit({
    required this.hit,
  });

  @override
  List<Object?> get props => [hit];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventRemoveHit extends GEvent {
  final String player;

  GEventRemoveHit({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventDecrementHitCancelable extends GEvent {
  @override
  List<Object?> get props => [];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

// MARK: - Engine events

class GEventActivate extends GEvent {
  final List<GMove> moves;

  GEventActivate({
    required this.moves,
  });

  @override
  List<Object?> get props => [moves];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventMove extends GEvent {
  final GMove move;

  GEventMove({
    required this.move,
  });

  @override
  List<Object?> get props => [move];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}

class GEventEmptyQueue extends GEvent {
  @override
  List<Object?> get props => [];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}
