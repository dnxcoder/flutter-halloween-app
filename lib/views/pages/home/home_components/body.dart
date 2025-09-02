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

class _Body extends State<Body> with TickerProviderStateMixin {
  double _fromScrollDx = 0;
  double _toScrollDx = 0;
  int _currentIndex = 0;

  late AnimationController _controllCarrousel;
  late final AnimationController _circleController;
  late final AnimationController _decorationImageController;

  @override
  void initState() {
    super.initState();
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _decorationImageController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    final WIDTH = MediaQuery.of(context).size.width;
    final HEIGHT = MediaQuery.of(context).size.height;
    final APPBARPORCENTAGE = (56 * 100) / HEIGHT;
    final BODYHEIGHT = HEIGHT - APPBARPORCENTAGE;

    final myList = [
      Item(
        name: "Spooky Doll",
        price: 209.99,
        width: WIDTH,
        imageSrc: "woman-hall.png",
        index: 0,
      ),
      Item(
        name: "Pumpkin\nKing",
        price: 209.99,
        width: WIDTH,
        imageSrc: "ghorst.png",
        index: 1,
      ),
      Item(
        name: "La Muerta",
        price: 209.99,
        width: WIDTH,
        imageSrc: "corpsebridge.png",
        index: 2,
      ),
      Item(
        name: "Skeleton\nGirl",
        price: 209.99,
        width: WIDTH,
        imageSrc: "skeleton-girl2.png",
        index: 3,
      ),
      Item(
        name: "Burger\nBandit",
        price: 209.99,
        width: WIDTH,
        imageSrc: "hamburger-man2.png",
        index: 4,
      ),
      Item(
        name: "Dragon Girl",
        price: 209.99,
        width: WIDTH,
        imageSrc: "child-dragon2.png",
        index: 5,
      ),
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
                bottom: BODYHEIGHT * 0.7 * 0.05,
                right: -40,
                child: Circle(
                  controller: _circleController,
                  currentIndex: _currentIndex,
                  decorationImageController: _decorationImageController,
                ),
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
      _currentIndex += 1;
    });

    carrouselController.forward(from: 0);
    _decorationImageController.forward(from: 0);
    circleController.toggle();
  }
}

class Item extends StatelessWidget {
  String name;
  double price;
  double width;
  String imageSrc;
  int index;

  Item({
    super.key,
    required this.width,
    required this.imageSrc,
    required this.index,
    required this.name,
    required this.price,
  });

  Widget leftImageRow(BoxConstraints constaints) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: constaints.maxHeight * 0.8,
            maxWidth: width * .6,
          ),
          child: Image.asset("assets/images/$imageSrc", height: 400),
        ),
        Transform.translate(
          offset: const Offset(0, -100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$200.99",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text("More ->", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget rightImageRow(BoxConstraints constaints) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: Offset(20, -200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$ 200.99",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text("More ->", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: constaints.maxHeight * 0.7,
            maxWidth: width * 0.6,
          ),

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
