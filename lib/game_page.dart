import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          _buildOther(context),
          _buildDeck(context),
          _buildYou(context),
          _buildHand(context),
        ],
      ),
    ));
  }

  Widget _buildOther(BuildContext context) {
    final players = List.generate(6, (index) => _buildPlayer(context, index));
    return IntrinsicHeight(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: players,
    ));
  }

  Widget _buildPlayer(BuildContext context, int index) {
    return Card(
      child: Container(
        width: 50,
        height: 100,
        child: Center(
          child: Text(
            'player $index',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildDeck(BuildContext context) {
    return Expanded(
      child: Center(
        child: _buildCard(context, -1),
      ),
    );
  }

  Widget _buildYou(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [_buildMessage(context), _buildPlayer(context, -1)],
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    final message =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque at sodales augue. Maecenas consequat odio in enim fringilla, id dapibus neque commodo.";
    return Expanded(child: Text(message));
  }

  Widget _buildHand(BuildContext context) {
    return Container(
      height: 260,
      child: GridView.count(
        childAspectRatio: 0.75,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        children: List.generate(8, (index) => _buildCard(context, index)),
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index) {
    return Card(
      child: Container(
        width: 90,
        height: 125,
        child: Center(
          child: Text('card $index'),
        ),
      ),
    );
  }
}
