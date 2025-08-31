import 'package:flutter/material.dart';

class Header extends AppBar {
  Header({super.key})
    : super(
        leading: Icon(Icons.close),
        title: Text("Halloween"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(Icons.format_underlined_outlined),
          ),
        ],
      );
}
