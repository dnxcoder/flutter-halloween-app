import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:halloween_app/views/pages/home/home_components/circle.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() {
    // TODO: implement createState
    return _Body();
  }
}

class _Body extends State<Body> with SingleTickerProviderStateMixin {
  double _fromScrollDx = 0;
  double _toScrollDx = 0;

  late AnimationController _controllCarrousel;
  late final AnimationController _circleController;

  @override
  void initState() {
    super.initState();
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  Widget build(BuildContext context) {
    final WIDTH = MediaQuery.of(context).size.width;
    final HEIGHT = MediaQuery.of(context).size.height;
    final APPBARPORCENTAGE = (56 * 100) / HEIGHT;
    final BODYHEIGHT = HEIGHT - APPBARPORCENTAGE;

    final myList = [
      Item(width: WIDTH, imageSrc: "woman-hall.png", index: 0),
      Item(width: WIDTH, imageSrc: "ghorst.png", index: 1),
      Item(width: WIDTH, imageSrc: "corpsebridge.png", index: 2),
      Item(width: WIDTH, imageSrc: "woman-hall.png", index: 3),
      Item(width: WIDTH, imageSrc: "ghorst.png", index: 4),
      Item(width: WIDTH, imageSrc: "corpsebridge.png", index: 5),
    ];

    debugPrint("ANYWAY $APPBARPORCENTAGE");
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.cancel_outlined, size: 40),
        title: Text("HALLOWEEN"),
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.directional(end: 4),
            child: Icon(Icons.abc, size: 40),
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                bottom: BODYHEIGHT * 0.7 * 0.3,
                right: WIDTH * 0.05,
                child: Circle(controller: _circleController).animate(),
              ),
              Container(
                height: BODYHEIGHT * 0.7,
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.purple, width: 4),
                ),
                child: Row(children: myList)
                    .animate(
                      onInit: (c) => _controllCarrousel = c,
                      autoPlay: false,
                    )
                    .moveX(
                      duration: Duration(milliseconds: 2000),
                      begin: _fromScrollDx,
                      end: _toScrollDx,
                      curve: Curves.elasticInOut,
                    ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => moveCarouselFoward(
              _controllCarrousel,
              _circleController,
              WIDTH,
            ),
            child: Text("ALOU"),
          ),
        ],
      ),
    );
  }

  void moveCarouselFoward(
    AnimationController carrouselController,
    AnimationController circleController,
    double offsetX,
  ) {
    setState(() {
      _fromScrollDx = _toScrollDx;
      _toScrollDx -= offsetX;
    });

    carrouselController.forward(from: 0);
    circleController.toggle();
  }
}

class Item extends StatelessWidget {
  double width;
  String imageSrc;
  int index;

  Item({
    super.key,
    required this.width,
    required this.imageSrc,
    required this.index,
  });

  Widget leftImageRow(BoxConstraints constaints) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: constaints.maxHeight * 0.7,
          child: Image.asset("assets/images/$imageSrc", height: 400),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "La Muerta",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$ 200.99",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(onPressed: () => {}, child: Text("More ->")),
          ],
        ),
      ],
    );
  }

  Widget rightImageRow(BoxConstraints constaints) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "La Muerta",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$ 200.99",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(onPressed: () => {}, child: Text("More ->")),
          ],
        ),
        SizedBox(
          height: constaints.maxHeight * 0.7,
          child: Image.asset("assets/images/$imageSrc", height: 400),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: width,
      //decoration: BoxDecoration(color: Colors.amber),
      child: LayoutBuilder(
        builder: (context, constaints) {
          return Container(
            alignment: Alignment.bottomCenter,
            child: index % 2 == 0
                ? leftImageRow(constaints)
                : rightImageRow(constaints),
          );
        },
      ),
    );
  }
}
