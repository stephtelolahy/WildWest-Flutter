part of 'state.dart';

class GPlayer extends GCard {
  final Role? role;
  int health;
  List<GCard> hand;
  List<GCard> inPlay;

  GPlayer({
    identifier = '',
    name = '',
    type = CardType.none,
    desc = '',
    abilities = const <String>[],
    attributes = const <CardAttributeKey, dynamic>{},
    value = '',
    this.role,
    this.health = 0,
    this.hand = const [],
    this.inPlay = const [],
  }) : super(
          identifier: identifier,
          name: name,
          type: type,
          desc: desc,
          abilities: abilities,
          attributes: attributes,
          value: value,
        );

  GPlayer.copy(GPlayer player)
      : role = player.role,
        health = player.health,
        hand = List.from(player.hand),
        inPlay = List.from(player.inPlay),
        super(
          identifier: player.identifier,
          name: player.name,
          type: player.type,
          desc: player.desc,
          abilities: player.abilities,
          attributes: player.attributes,
          value: player.value,
        );
}

enum Role {
  sheriff,
  outlaw,
  renegade,
  deputy,
}
