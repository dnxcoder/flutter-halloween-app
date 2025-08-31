import 'package:flutter/material.dart';
import 'package:halloween_app/views/pages/home/home_components/body.dart';
import 'package:halloween_app/views/pages/home/home_components/header.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(appBar: Header(), body: Body());
  }
}
