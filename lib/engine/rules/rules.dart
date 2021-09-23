import 'package:collection/collection.dart';

import '../event/event.dart';
import '../state/state.dart';
import 'ability.dart';
import 'play_context.dart';

class GRules {
  final List<Ability> abilities;

  GRules({required this.abilities});

  Role? isGameOver(GState state) {
    final Iterable<Role> remainingRoles =
        state.playOrder.map((e) => state.player(identifier: e).role!);

    final outlawAndRenegateEliminated =
        !remainingRoles.contains(Role.outlaw) && !remainingRoles.contains(Role.renegade);
    if (outlawAndRenegateEliminated) {
      return Role.sheriff;
    }

    final sheriffEliminated = !remainingRoles.contains(Role.sheriff);
    if (sheriffEliminated) {
      final lastIsRenegade = remainingRoles.length == 1 && remainingRoles.first == Role.renegade;
      if (lastIsRenegade) {
        return Role.renegade;
      } else {
        return Role.outlaw;
      }
    }

    return null;
  }

  List<GMove> active(GState state) {
    List<GMove> result = [];

    final actorId = state.hit?.players.first ?? state.turn;
    final actor = state.player(identifier: actorId);

    actor.abilities.forEach((ability) {
      if (_isAbilitySilenced(ability, actor)) {
        return;
      }

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
    List<GMove> result = [];

    final actorIds = Set.from(state.playOrder);

    // <RULE>: trigger moves from just eliminated player
    if (event is GEventEliminate) {
      actorIds.add(event.player);
    }
    // </RULE>

    for (var actorId in actorIds) {
      final actor = state.player(identifier: actorId);

      actor.abilities.forEach((ability) {
        if (_isAbilitySilenced(ability, actor)) {
          return;
        }

        result.addAll(_moves(
          type: AbilityType.triggered,
          ctx: PlayContext(
            ability: ability,
            actor: actor,
            state: state,
            event: event,
          ),
        ));
      });

      actor.inPlay.forEach((card) {
        state._abilitiesApplicableToInPlay(card, actor).forEach((ability) {
          result.addAll(_moves(
            type: AbilityType.triggered,
            ctx: PlayContext(
                ability: ability,
                actor: actor,
                state: state,
                inPlayCard: card.identifier,
                event: event),
          ));
        });
      });
    }

    return result.sorted((a, b) =>
        abilities.firstWhere((e) => e.name == a.ability).priority -
        abilities.firstWhere((e) => e.name == b.ability).priority);
  }

  List<GEvent> effects(GMove move, GState state) {
    List<GEvent> result = [];

    final actor = state.player(identifier: move.actor);
    final abilityObject = abilities.firstWhere((e) => e.name == move.ability);
    final ctx = PlayContext(
      ability: move.ability,
      actor: actor,
      state: state,
      handCard: move.handCard,
      inPlayCard: move.inPlayCard,
      args: move.args,
    );

    for (var effect in abilityObject.onPlay) {
      final events = effect.apply(ctx);
      if (events.isEmpty) {
        return [];
      }

      result.addAll(events);
    }

    // <RULE> remove effect if target has silentCard
    result.removeWhere((e) => _isEffectSilenced(e, ctx));
    // </RULE>

    if (result.isEmpty) {
      return [];
    }

    // <RULE> discard immediately played brown hand card
    final handCard = move.handCard;
    if (handCard != null &&
        actor.hand.firstWhere((e) => e.identifier == handCard).type == CardType.brown) {
      result.insert(0, GEventDiscardHand(player: move.actor, card: handCard));
    }
    // </RULE>

    return result;
  }

  List<GMove> _moves({required AbilityType type, required PlayContext ctx}) {
    List<GMove> result = [];

    final abilityObject = abilities.firstWhereOrNull((e) => e.name == ctx.ability);
    if (abilityObject == null || abilityObject.type != type) {
      return [];
    }

    List<PlayArgs> args = [];
    final match = abilityObject.canPlay.every((e) => e.match(ctx, args));
    if (!match) {
      return [];
    }

    if (args.isNotEmpty) {
      result.addAll(args.map((e) => GMove(
            ability: ctx.ability,
            actor: ctx.actor.identifier,
            handCard: ctx.handCard,
            inPlayCard: ctx.inPlayCard,
            args: e,
          )));
    } else {
      result.add(GMove(
          ability: ctx.ability,
          actor: ctx.actor.identifier,
          handCard: ctx.handCard,
          inPlayCard: ctx.inPlayCard));
    }

    // <RULE> A move is applicable when it has effects>
    result.removeWhere((e) => effects(e, ctx.state).isEmpty);
    // </RULE>

    return result;
  }

  bool _isEffectSilenced(GEvent event, PlayContext ctx) {
    final handCard = ctx.handCard;
    if (handCard == null) {
      return false;
    }
    final cardObject = ctx.actor.hand.firstWhere((e) => e.identifier == handCard);

    if (event is GEventHandicap) {
      final targetObject = ctx.state.player(identifier: event.other);
      if (targetObject.attributes.silentCard == cardObject.name) {
        return true;
      }
    }

    return false;
  }

  bool _isAbilitySilenced(String ability, GPlayer player) {
    return player.attributes.silentAbility == ability;
  }
}

extension ApplicableAbilities on GState {
  List<String> _abilitiesApplicableToHand(GCard card, GPlayer player) {
    return card.abilities;
  }

  List<String> _abilitiesApplicableToInPlay(GCard card, GPlayer player) {
    return card.abilities;
  }
}
