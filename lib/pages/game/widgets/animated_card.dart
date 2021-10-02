import 'package:flutter/material.dart';
import 'package:wildwest_flutter/engine/state/state.dart';
import 'package:wildwest_flutter/pages/game/widgets/card.dart';

// https://flutter.dev/docs/development/ui/animations/staggered-animations
class AnimatedCard extends StatefulWidget {
  const AnimatedCard({Key? key}) : super(key: key);

  @override
  AnimatedCardState createState() => AnimatedCardState();
}

class AnimatedCardState extends State<AnimatedCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _opacity;
  Animation<Offset>? _offset;
  GCard _card = GCard();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration.zero,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _opacity = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.ease)),
          weight: 0.1,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(1.0),
          weight: 99.8,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.ease)),
          weight: 0.1,
        ),
      ],
    ).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final left = (_offset?.value.dx ?? 0) - CardWidget.CARD_WIDTH / 2;
    final top = (_offset?.value.dy ?? 0) - CardWidget.CARD_HEIGHT / 2;
    final opacity = _opacity?.value ?? 0;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Positioned(
        left: left,
        top: top,
        child: Opacity(
          opacity: opacity,
          child: child,
        ),
      ),
      child: IgnorePointer(
        child: CardWidget(card: _card, color: Colors.amber),
      ),
    );
  }

  void animate(
      {required Duration duration,
      required String? cardId,
      required Offset from,
      required Offset to}) async {
    _controller.duration = duration;
    _card = _cardFromId(cardId);
    _offset = Tween<Offset>(begin: from, end: to).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    await _controller.forward(from: 0.0);
  }

  GCard _cardFromId(String? cardId) {
    if (cardId == null) {
      return GCard();
    } else {
      final cardParts = cardId.split('-');
      final cardName = cardParts[0];
      final cardValue = cardParts[1];
      return GCard(id: cardId, name: cardName, value: cardValue);
    }
  }
}
