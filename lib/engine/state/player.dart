part of 'state.dart';

class GPlayer extends GCard {
  final Role? role;
  int health;
  final List<GCard> hand;
  final List<GCard> inPlay;

  GPlayer({
    identifier = '',
    name = '',
    type = CardType.none,
    desc = '',
    abilities = const <String>[],
    bullets,
    mustang,
    scope,
    weapon,
    flippedCards,
    bangsPerTurn,
    handLimit,
    silentCard,
    silentAbility,
    playAs,
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
          bullets: bullets,
          mustang: mustang,
          scope: scope,
          weapon: weapon,
          flippedCards: flippedCards,
          bangsPerTurn: bangsPerTurn,
          handLimit: handLimit,
          silentCard: silentCard,
          silentAbility: silentAbility,
          playAs: playAs,
        );

  GPlayer.fromCard(GCard card,
      {this.role, required this.health, required this.hand, required this.inPlay})
      : super(
            identifier: card.name,
            name: card.name,
            type: card.type,
            desc: card.desc,
            value: card.value,
            abilities: card.abilities,
            bullets: card.bullets,
            mustang: card.mustang,
            scope: card.scope,
            weapon: card.weapon,
            flippedCards: card.flippedCards,
            bangsPerTurn: card.bangsPerTurn,
            handLimit: card.handLimit,
            silentCard: card.silentCard,
            silentAbility: card.silentAbility,
            playAs: card.playAs);

  @override
  List<Object?> get props =>
      super.props +
      [
        role,
        health,
        hand,
        inPlay,
      ];

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
        );
}

enum Role {
  sheriff,
  outlaw,
  renegade,
  deputy,
}
