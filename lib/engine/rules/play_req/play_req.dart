import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/rules/play_req/play_req_utils.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

import '../play_context.dart';
part 'is_your_turn.dart';
part 'is_phase.dart';
part 'is_players_count_min.dart';
part 'is_times_per_turn_max.dart';
part 'is_times_per_turn_max_bangs_per_turn.dart';
part 'is_hit_effect.dart';
part 'is_hit_name.dart';
part 'is_health.dart';
part 'is_hit_cancelable.dart';
part 'on_hit_cancelable.dart';
part 'on_phase.dart';
part 'on_queue_empty.dart';
part 'require_target_other.dart';
part 'require_target_any.dart';
part 'require_target_at.dart';
part 'require_target_reachable.dart';
part 'require_inplay_card.dart';
part 'require_store_cards.dart';

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

      case 'isHitEffect':
        return IsHitEffect(ability: value as String);

      case 'isHitName':
        return IsHitName(hitName: value as String);

      case 'isHealth':
        return IsHealth(health: value as int);

      case 'isHitCancelable':
        return IsHitCancelable();

      case 'isTimesPerTurnMax':
        return IsTimesPerTurnMax(maxTimes: value as int);

      case 'isTimesPerTurnMaxBangsPerTurn':
        return IsTimesPerTurnMaxBangsPerTurn();

      case 'onHitCancelable':
        return OnHitCancelable();

      case 'onPhase':
        return OnPhase(phase: value as int);

      case 'onQueueEmpty':
        return OnQueueEmpty();

      case 'requireTargetOther':
        return RequireTargetOther();

      case 'requireTargetAny':
        return RequireTargetAny();

      case 'requireTargetAt':
        return RequireTargetAt(distance: value as int);

      case 'requireTargetReachable':
        return RequireTargetReachable();

      case 'requireInPlayCard':
        return RequireInPlayCard();

      case 'requireStoreCards':
        return RequireStoreCards(amount: value as int);

      default:
        throw Exception('Unknown playReq: $key');
    }
  }
}
