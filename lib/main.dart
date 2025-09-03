import 'package:flutter/material.dart';
import 'package:halloween_app/views/pages/home/home.dart';
import 'package:halloween_app/views/pages/home/home_components/animations_play.dart';
import 'package:halloween_app/views/pages/home/home_components/body.dart';
import 'package:flutter/rendering.dart'; // <-- aqui que está o debugPaintSizeEnabled

void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Body(),
    );
  }
}
