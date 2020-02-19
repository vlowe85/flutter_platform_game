import 'package:flutter/material.dart';
import 'package:flutter_jump_game/constants.dart';
import 'package:flutter_jump_game/platform_piece.dart';

import 'point.dart';


class Platform {
  Color colour;
  Point position;
  double height;
  double width;

  Platform({this.colour, this.position, this.height, this.width});

  bool contains(double x, double y) {
    // this sucks, the character stands inside the platform most of the time :(
    return this.position.x / PLAYER_SIZE <= x && x <= (this.position.x + this.width) / PLAYER_SIZE &&
        (this.position.y - this.height) / PLAYER_SIZE <= y && y <= this.position.y / PLAYER_SIZE;
  }

  Widget draw() {
    return PlatformPiece(colour: this.colour, width: this.width, height: this.height);
  }
}