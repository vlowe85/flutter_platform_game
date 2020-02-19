import 'package:flutter/material.dart';
import 'package:flutter_jump_game/constants.dart';

import 'point.dart';


class Player {
  Color colour;
  Point position;
  double speedX = 0;
  double speedY = 0;
  double gravity = 0.05;
  double gravitySpeed = 0;

  double velocity = 0.2;
  double jumpSpeed = 0;
  double jumpStart;

  bool jumping = false;
  bool moveRight = false;
  bool moveLeft = false;
  bool falling = true;

  Player({this.colour, this.position});

  void update() {

    if (jumping) {
      this.jumpSpeed += this.velocity;
      this.position.y -= this.jumpSpeed;
      if(this.position.y <= (this.jumpStart - (PLAYER_SIZE / 2)))  {
        jumping = false;
      }
    } else {
      this.jumpSpeed = 0;
    }

    if (falling) {
      this.gravitySpeed += this.gravity;
      this.position.x += this.speedX;
      this.position.y += this.speedY + this.gravitySpeed;
    } else {
      this.gravitySpeed = 0;
    }

    if (moveRight) {
      this.position.x += 0.5;
    }

    if (moveLeft) {
      this.position.x -= 0.5;
    }
  }

  void jump() {

    if(falling) return;
    jumpStart = position.y;
    this.jumping = true;
  }
}