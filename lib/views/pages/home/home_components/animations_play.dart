import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimationsPlay extends StatefulWidget {
  const AnimationsPlay({super.key});
  @override
  State<AnimationsPlay> createState() => _AnimationsPlay();
}

class _AnimationsPlay extends State<AnimationsPlay> {
  //const _AnimationsPlay({super.key});
  late AnimationController _controller;
  late AnimationController _scaleCtrl; // controla a escala
  late AnimationController _moveCtrl; // controla o movimento

  double _fromDx = 0;
  double _toDx = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            height: 200,
            decoration: BoxDecoration(color: Colors.lightBlue),
            child: Circle()
                //BLOCK ONE CONTROLL
                .animate(onInit: (c) => _scaleCtrl = c)
                .scale(
                  duration: Duration(seconds: 1),
                  begin: Offset(.1, .1),
                  end: Offset(0.5, .5),
                )
                //Move controll
                .animate(onInit: (c) => _moveCtrl = c, autoPlay: false)
                .moveX(
                  duration: Duration(milliseconds: 1000),
                  begin: _fromDx,
                  end: _toDx,
                  curve: Curves.elasticIn,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => {_scaleCtrl.toggle()},
                  child: Text("Toggle size"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _fromDx = _toDx;
                      _toDx += 50;
                    });
                    _moveCtrl.forward(from: 0);
                  },
                  child: Wrap(children: [Text("Move F 200px")]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Circle extends StatelessWidget {
  const Circle({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
    );
  }
}
