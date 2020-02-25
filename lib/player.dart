import 'package:flutter/material.dart';
import 'package:flutter_jump_game/constants.dart';

import 'point.dart';


class Player {
  Color colour;
  Point position;
  double speedX = 0;
  double speedY = 0;
  double gravity = 0.4;
  double gravitySpeed = 0;
  double maxSpeedX = 5;

  double velocity = 0.0100;
  double jumpSpeed = 0.0500;
  double jumpStart;

  bool jumping = false;
  bool moveRight = false;
  bool moveLeft = false;
  bool falling = true;

  Player({this.colour, this.position});

  void update() {

    if (jumping) {
      this.position.y -= this.jumpSpeed;
      this.jumpSpeed -= this.velocity;
      this.velocity -= 0.010;
      if(this.position.y <= (this.jumpStart - (PLAYER_SIZE * 4 )))  {
        jumping = false;
      }
    } else {
      this.jumpSpeed = 0;
    }

    if (falling) {
      this.gravitySpeed += this.gravity;
      this.position.y += this.speedY + this.gravitySpeed;
    } else {
      this.gravitySpeed = 0;
    }

    if (moveRight) {
      if (speedX < maxSpeedX) speedX += 0.1;
      this.position.x += speedX;
    }

    if (moveLeft) {
      if (speedX < maxSpeedX) speedX += 0.1;
      this.position.x -= speedX;
    }
  }

  void jump() {

    if(falling) return;
    speedX = speedX / 2;
    jumpStart = position.y;
    this.jumping = true;
  }
}