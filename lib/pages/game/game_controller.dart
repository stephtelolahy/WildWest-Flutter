import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wildwest_flutter/engine/engine.dart';
import 'package:wildwest_flutter/engine/misc/list_extensions.dart';
import 'package:wildwest_flutter/engine/rules/rules.dart';
import 'package:wildwest_flutter/engine/setup/loader.dart';
import 'package:wildwest_flutter/engine/setup/setup.dart';
import 'package:wildwest_flutter/engine/state/state.dart';
import 'package:wildwest_flutter/engine/event/event.dart';

class GameController extends GetxController {
  late GEngine _engine;
  late String _controlledId;

  Rx<GState?> state = Rx(null);
  Rx<GEvent?> event = Rx(null);

  // TODO: convert to Rx properties
  GCard? get discard => state.value!.discard.isNotEmpty ? state.value!.discard.last : null;

  GPlayer get you => state.value!.player(id: _controlledId);

  List<GPlayer> get others =>
      state.value!.players.startingWhere((e) => e.id == _controlledId).skip(1).toList();

  @override
  void onInit() {
    _loadGame();
    super.onInit();
  }

  Future<void> _loadGame() async {
    final loader = ResLoader();
    final abilities = await loader.loadAbilities();
    final cards = await loader.loadCards();
    final cardValues = await loader.loadCardValues();
    final rules = GRules(abilities: abilities);
    final setup = GSetup();
    final roles = setup.roles(playersCount: 5);
    final deck = setup.deck(cards: cards, values: cardValues);
    final figures = cards.where((e) => e.type == CardType.figure).toList();
    final defaults = cards.where((e) => e.type == CardType.none).toList();
    final initialState = setup.game(roles: roles, figures: figures, defaults: defaults, deck: deck);

    _controlledId = initialState.players.singleWhere((e) => e.role == Role.sheriff).id;
    state.value = initialState;

    _engine = GEngine(state: initialState, rules: rules, eventDurationMillis: 400);

    _engine.stateSubject.listen((aState) {
      state.value = aState;
    });

    _engine.eventSubject.listen((anEvent) {
      print(anEvent);
      event.value = anEvent;
    });
  }

  Future<void> run() async {
    // TODO: use worker to avoid multiple run
    _engine.eventSubject.listen((anEvent) {
      if (anEvent is GEventActivate) {
        final best = anEvent.moves.randomElement();
        _engine.play(best);
      }
    });
    await _engine.refresh();
  }
}
