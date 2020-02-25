import 'package:flutter/material.dart';
import 'package:flutter_jump_game/platform_piece.dart';

import 'point.dart';


class Platform {
  Color colour;
  Point position;
  double height;
  double width;

  Platform({this.colour, this.position, this.height, this.width});

  Widget draw() {
    return PlatformPiece(colour: this.colour, width: this.width, height: this.height);
  }
}