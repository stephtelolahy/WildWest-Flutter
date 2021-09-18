import 'package:wildwest_flutter/engine/rules/play_context.dart';

import '../event/event.dart';
import '../setup/ability.dart';
import '../state/state.dart';

class GRules {
  final List<ResAbility> abilities;

  GRules({required this.abilities});

  List<GMove> active(GState state) {
    List<GMove> result = [];

    final actorId = state.hit?.players.first ?? state.turn;
    final actor = state.player(identifier: actorId);

    state._abilitiesApplicableToPlayer(actor).forEach((ability) {
      result.addAll(_moves(
        type: AbilityType.active,
        ctx: PlayContext(ability: ability, actor: actor, state: state),
      ));
    });

    actor.hand.forEach((card) {
      state._abilitiesApplicableToHand(card, actor).forEach((ability) {
        result.addAll(_moves(
          type: AbilityType.active,
          ctx: PlayContext(ability: ability, actor: actor, state: state, handCard: card.identifier),
        ));
      });
    });

    final hit = state.hit;
    if (hit != null && hit.players.first == actorId) {
      hit.abilities.forEach((ability) {
        result.addAll(_moves(
          type: AbilityType.active,
          ctx: PlayContext(ability: ability, actor: actor, state: state),
        ));
      });
    }

    return result;
  }

  List<GMove> triggered(GEvent event, GState state) {
    throw UnimplementedError();
  }

  List<GEvent> effects(GMove move, GState state) {
    List<GEvent> result = [];

    final actor = state.player(identifier: move.actor);
    final abilityObject = abilities.firstWhere((e) => e.name == move.ability);
    final ctx = PlayContext.fromMove(move, state: state);

    for (var effect in abilityObject.onPlay) {
      final events = effect.apply(ctx);
      if (events.isNotEmpty || effect.optional) {
        result.addAll(events);
      } else {
        return [];
      }
    }

    if (result.isEmpty) {
      return [];
    }

    // <RULE> discard immediately played brown hand card
    final handCard = move.handCard;
    if (handCard != null &&
        actor.hand.firstWhere((e) => e.identifier == handCard).type == CardType.brown) {
      result.insert(0, GEventPlay(player: move.actor, card: handCard));
    }
    // </RULE>

    return result;
  }

  Role? isGameOver(GState state) {
    throw UnimplementedError();
  }
}

extension ApplicableAbilities on GState {
  List<String> _abilitiesApplicableToPlayer(GPlayer player) {
    return player.abilities;
  }

  List<String> _abilitiesApplicableToHand(GCard card, GPlayer player) {
    return card.abilities;
  }
}

extension GenerateMoves on GRules {
  List<GMove> _moves({required AbilityType type, required PlayContext ctx}) {
    List<GMove> result = [];

    final abilityObject = abilities.firstWhere((e) => e.name == ctx.ability);
    if (abilityObject.type != type) {
      return [];
    }

    List<PlayArgs> args = [];
    final match = abilityObject.canPlay.every((e) => e.match(ctx, args));
    if (!match) {
      return [];
    }

    if (args.isNotEmpty) {
      result.addAll(args.map((e) => GMove(
          ability: ctx.ability, actor: ctx.actor.identifier, handCard: ctx.handCard, args: e)));
    } else {
      result.add(GMove(ability: ctx.ability, actor: ctx.actor.identifier, handCard: ctx.handCard));
    }

    // <RULE> A move is applicable when it has effects>
    result.removeWhere((e) => effects(e, ctx.state).isEmpty);
    // </RULE>

    return result;
  }
}
