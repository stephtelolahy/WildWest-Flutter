import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wildwest_flutter/pages/animation/animated_card.dart';

class AnimationPage extends StatelessWidget {
  final _key1 = GlobalKey();
  final _key2 = GlobalKey();
  final _animatedKey = GlobalKey<AnimatedCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
              child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: _buildBox(color: Colors.red, key: _key1),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildBox(color: Colors.green, key: _key2),
              ),
            ],
          )),
          AnimatedCard(key: _animatedKey),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _animatedKey.currentState?.animate(_key1, _key2),
        child: Icon(Icons.play_arrow),
      ),
    );
  }

  Widget _buildBox({Key? key, required Color color}) {
    return Container(
      key: key,
      color: color,
      width: 50,
      height: 50,
    );
  }
}
