import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Circle extends StatefulWidget {
  final AnimationController controller;
  final AnimationController decorationImageController;
  final int currentIndex;

  const Circle({
    super.key,
    required this.controller,
    required this.currentIndex,
    required this.decorationImageController,
  });

  @override
  State<Circle> createState() {
    // TODO: implement createState
    return _Circle();
  }
}

class _Circle extends State<Circle> {
  final List<String> listOfImages = [
    "castle2.png",
    "pumpkin2.png",
    "lamuerta4.png",
    "skeleton7.png",
    "hamb3.png",
    "dragon2.png",
  ];

  String selectedImageSrc = "castle.png";

  @override
  Widget build(BuildContext context) {
    AnimationController circleController = widget.controller;
    AnimationController _decorationImageController =
        widget.decorationImageController;
    int currentIndex = widget.currentIndex;

    final down = 1000.ms;
    final up = 1500.ms;

    // TODO: implement build
    return ClipOval(
          child: Container(
            width: 300,
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(200),
                topRight: Radius.circular(200),
                bottomLeft: Radius.circular(200),
                bottomRight: Radius.circular(200),
              ),
            ),
            child:
                Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        "assets/images/${selectedImageSrc}",
                        width: 270,
                      ),
                    )
                    /// CANAL 1: movimento (desce e depois sobe)
                    .animate(
                      controller: _decorationImageController,
                      autoPlay: false,
                      onPlay: (c) => c.forward(from: 0),
                    )
                    .moveY(
                      duration: down,
                      begin: 0,
                      end: 400,
                      curve: Curves.easeIn,
                    )
                    .then()
                    .callback(
                      duration: 0.ms,
                      callback: (_) {
                        setState(() {
                          selectedImageSrc = listOfImages[currentIndex];
                        });
                      },
                    )
                    .moveY(
                      duration: up,
                      begin: 0,
                      end: -400,
                      curve: Curves.fastOutSlowIn,
                    )
                    // CANAL 2: escala + troca de imagem, tudo em sequência
                    .animate(
                      controller: _decorationImageController,
                      autoPlay: false,
                    )
                    .scaleXY(
                      duration: down,
                      begin: 1,
                      end: 0.5,
                      curve: Curves.easeOut,
                      alignment: Alignment.bottomCenter,
                    )
                    .then()
                    .scaleXY(
                      duration: up,
                      begin: 1,
                      end: 2,
                      curve: Curves.easeOut,
                      alignment: Alignment.bottomCenter,
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
