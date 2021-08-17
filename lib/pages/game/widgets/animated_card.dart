import 'package:flutter/material.dart';
import 'package:wildwest_flutter/pages/game/widgets/card.dart';

// https://flutter.dev/docs/development/ui/animations/staggered-animations
class AnimatedCard extends StatefulWidget {
  const AnimatedCard({Key? key}) : super(key: key);

  @override
  AnimatedCardState createState() => AnimatedCardState();
}

class AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _opacity;
  Animation<Offset>? _offset;
  String? _card;

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
          tween: Tween<double>(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 0.1,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(1.0),
          weight: 99.8,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 0.0)
              .chain(CurveTween(curve: Curves.ease)),
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
    final left = _offset?.value.dx;
    final top = _offset?.value.dy;
    final opacity = _opacity?.value ?? 0.0;
    final name = _card ?? '';
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
        child: CardWidget(name: name, color: Colors.amber),
      ),
    );
  }

  void animate(
      {required Duration duration,
      required String card,
      required GlobalKey fromKey,
      required GlobalKey toKey}) async {
    _controller.duration = duration;
    _card = card;

    final beginOffset = _offsetForCardCenteredAt(fromKey);
    final endOffset = _offsetForCardCenteredAt(toKey);
    _offset = Tween<Offset>(begin: beginOffset, end: endOffset).animate(
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

  static Offset _offsetForCardCenteredAt(GlobalKey key) {
    final box = key.currentContext?.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final centerX = offset.dx + box.size.width / 2.0;
    final centerY = offset.dy + box.size.height / 2.0;
    final left = centerX - CardWidget.CARD_WIDTH / 2.0;
    final top = centerY - CardWidget.CARD_HEIGHT / 2.0;
    return Offset(left, top);
  }
}
