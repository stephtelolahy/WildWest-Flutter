part of 'state.dart';

class GPlayer extends GCard {
  final Role? role;
  int health;
  List<GCard> hand;
  List<GCard> inPlay;

  GPlayer(
    String identifier,
    String name,
    CardType type,
    String desc,
    List<String> abilities,
    Map<CardAttributeKey, dynamic> attributes,
    String value, {
    required this.role,
    required this.health,
    required this.hand,
    required this.inPlay,
  }) : super(
          identifier: identifier,
          name: name,
          type: type,
          desc: desc,
          abilities: abilities,
          attributes: attributes,
          value: value,
        );
}

enum Role {
  sheriff,
  outlaw,
  renegade,
  deputy,
}
