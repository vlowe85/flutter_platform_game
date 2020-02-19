import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlatformPiece extends StatelessWidget {
  final Color colour;
  final double height;
  final double width;
  PlatformPiece({this.colour, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colour,
      )
    );
  }
}