import 'package:enum_to_string/enum_to_string.dart';

import '../../event/event.dart';
import '../play_context.dart';

part 'argument/card_argument.dart';
part 'argument/player_argument.dart';
part 'equip.dart';

abstract class Effect {
  // TODO: parse optional
  final bool optional = false;

  List<GEvent> apply(PlayContext ctx);

  static Effect fromJson(Map<String, dynamic> json) {
    final key = json['action'] as String;
    switch (key) {
      case 'equip':
        return Equip.fromJson(json);

      default:
        print('Unknown effect: $key');
        return DummyEffect();
      // throw Exception('Unknown effect: $key');
    }
  }
}

class DummyEffect extends Effect {
  @override
  List<GEvent> apply(PlayContext ctx) => [];
}
