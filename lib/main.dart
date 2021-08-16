import 'package:flutter/material.dart';
import 'package:wildwest_flutter/pages/animation/animation_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: AnimationPage(), //GamePage(),
    );
  }
}
