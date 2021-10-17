import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'pages/game/game_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: GamePage(),
    );
  }
}
