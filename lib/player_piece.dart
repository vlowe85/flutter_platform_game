import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jump_game/constants.dart';


class PlayerPiece extends StatelessWidget {
  final Color colour;
  PlayerPiece({this.colour});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: PLAYER_SIZE,
      height: PLAYER_SIZE,
      decoration: BoxDecoration(
        color: colour,
//        boxShadow: [
//          BoxShadow(
//            color: colour.withAlpha(255),
//            blurRadius: 6.0,
//            spreadRadius: 1.5,
//            offset: Offset(
//              0.0,
//              0.0,
//            ),
//          ),
//        ],
      )
    );
  }
}