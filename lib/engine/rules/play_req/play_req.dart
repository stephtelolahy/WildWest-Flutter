import 'package:enum_to_string/enum_to_string.dart';

import '../../event/event.dart';
import '../../list_extensions.dart';
import '../../state/state.dart';
import '../play_context.dart';
import '../state_extensions.dart';

part 'is_hand_exceed_limit.dart';
part 'is_health.dart';
part 'is_hit_ability.dart';
part 'is_hit_name.dart';
part 'is_phase.dart';
part 'is_players_count_min.dart';
part 'is_times_per_turn_max.dart';
part 'is_times_per_turn_max_bangs_per_turn.dart';
part 'is_your_turn.dart';
part 'on_eliminated.dart';
part 'on_eliminating_role.dart';
part 'on_hand_empty.dart';
part 'on_hit_ability.dart';
part 'on_loose_health.dart';
part 'on_phase.dart';
part 'on_queue_empty.dart';
part 'play_args_extensions.dart';
part 'require_deck_cards.dart';
part 'require_hand_cards.dart';
part 'require_store_cards.dart';
part 'require_target_any.dart';
part 'require_target_at.dart';
part 'require_target_card.dart';
part 'require_target_eliminated.dart';
part 'require_target_hit.dart';
part 'require_target_offender.dart';
part 'require_target_other.dart';
part 'require_target_reachable.dart';

abstract class PlayReq {
  bool match(PlayContext ctx, List<PlayArgs> args);

  static PlayReq fromKey(String key, {dynamic value}) {
    switch (key) {
      case 'isYourTurn':
        return IsYourTurn();

      case 'isPhase':
        return IsPhase(phase: value as int);

      case 'isPlayersCountMin':
        return IsPlayersCountMin(minPlayersCount: value as int);

      case 'isHitAbility':
        return IsHitAbility(ability: value as String);

      case 'isHitName':
        return IsHitName(hitName: value as String);

      case 'isHealth':
        return IsHealth(health: value as int);

      case 'isTimesPerTurnMax':
        return IsTimesPerTurnMax(maxTimes: value as int);

      case 'isTimesPerTurnMaxBangsPerTurn':
        return IsTimesPerTurnMaxBangsPerTurn();

      case 'isHandExceedLimit':
        return IsHandExceedLimit();

      case 'onPhase':
        return OnPhase(phase: value as int);

      case 'onQueueEmpty':
        return OnQueueEmpty();

      case 'onEliminated':
        return OnEliminated();

      case 'onEliminatingRole':
        return OnEliminatingRole(role: EnumToString.fromString(Role.values, value)!);

      case 'onLooseHealth':
        return OnLooseHealth();

      case 'onHandEmpty':
        return OnHandEmpty();

      case 'onHitAbility':
        return OnHitAbility(ability: value as String);

      case 'requireTargetOther':
        return RequireTargetOther();

      case 'requireTargetAny':
        return RequireTargetAny();

      case 'requireTargetAt':
        return RequireTargetAt(distance: value as int);

      case 'requireTargetReachable':
        return RequireTargetReachable();

      case 'requireTargetOffender':
        return RequireTargetOffender();

      case 'requireTargetEliminated':
        return RequireTargetEliminated();

      case 'requireTargetHit':
        return RequireTargetHit();

      case 'requireStoreCard':
        return RequireStoreCard();

      case 'requireHandCards':
        return RequireHandCards(amount: value as int);

      case 'requireDeckCards':
        return RequireDeckCards(amount: value as int);

      case 'requireTargetCard':
        return RequireTargetCard();

      default:
        throw Exception('Unknown playReq: $key');
    }
  }
}
