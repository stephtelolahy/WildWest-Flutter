import 'package:flutter/material.dart';
import 'package:wildwest_flutter/pages/game/widgets/card.dart';

// https://flutter.dev/docs/development/ui/animations/staggered-animations
class AnimatedCard extends StatefulWidget {
  const AnimatedCard({Key? key}) : super(key: key);

  @override
  AnimatedCardState createState() => AnimatedCardState();
}

class AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin<AnimatedCard> {
  late AnimationController _controller;
  Animation<double>? _opacity;
  Animation<Offset>? _offset;
  String? _card;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
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
      builder: (context, child) => Positioned(
        left: left,
        top: top,
        child: Opacity(
          opacity: opacity,
          child: CardWidget(name: name),
        ),
      ),
      animation: _controller,
    );
  }

  Future<void> animate(
      {required String card,
      required GlobalKey fromKey,
      required GlobalKey toKey}) async {
    _card = card;

    final beginBox = fromKey.currentContext?.findRenderObject() as RenderBox;
    Offset beginOffset = beginBox.localToGlobal(Offset.zero);

    final endBox = toKey.currentContext?.findRenderObject() as RenderBox;
    Offset endOffset = endBox.localToGlobal(Offset.zero);

    _offset = Tween<Offset>(begin: beginOffset, end: endOffset).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    await _controller.forward(from: 0.0);
  }
}
