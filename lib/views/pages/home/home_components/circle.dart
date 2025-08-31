import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Circle extends StatefulWidget {
  final AnimationController controller;

  const Circle({super.key, required this.controller});

  @override
  State<Circle> createState() {
    // TODO: implement createState
    return _Circle();
  }
}

class _Circle extends State<Circle> {
  @override
  Widget build(BuildContext context) {
    double _fromDxCircle = 0;
    double _toDxCircle = 0;

    double _fromDyCircle = 0;
    double _toDyCircle = 0;

    AnimationController circleController = widget.controller;

    // TODO: implement build
    return Container(
          width: 250,
          height: 250,
          decoration: const BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(200),
              topRight: Radius.circular(200),
              bottomLeft: Radius.circular(200),
              bottomRight: Radius.circular(200),
            ),
          ),
        )
        .animate(controller: circleController, autoPlay: false)
        .moveX(
          duration: Duration(milliseconds: 2000),
          begin: 0,
          end: -100,
          curve: Curves.elasticInOut,
        )
        .moveY(
          duration: Duration(milliseconds: 2000),
          begin: 0,
          end: -30,
          curve: Curves.elasticInOut,
        )
        .scaleXY(
          duration: Duration(milliseconds: 2000),
          begin: 1,
          end: 1.3,
          curve: Curves.elasticInOut,
        );
  }
}
