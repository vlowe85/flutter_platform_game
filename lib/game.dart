import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jump_game/constants.dart';
import 'package:flutter_jump_game/controls.dart';
import 'package:flutter_jump_game/platform.dart';
import 'package:flutter_jump_game/player.dart';
import 'package:flutter_jump_game/player_piece.dart';
import 'package:flutter_jump_game/point.dart';


class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameState();
}

enum GameState { PLAYING, GAME_OVER }


class _GameState extends State<Game> {
  Timer _timer;
  GameState _gameState;
  Player _player;
  FocusNode _focusNode = FocusNode();
  List<Platform> _platforms = [];

  @override
  void initState() {
    super.initState();
    // prepare to start
    _prepareStartGame();
  }


  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return Container(
        width: LEVEL_SIZE,
        height: LEVEL_SIZE,
        decoration: BoxDecoration(
          color: Colors.black26,
          border: Border.all(color: Colors.white),
        ),
        child: RawKeyboardListener(
          focusNode: _focusNode,
          onKey: (RawKeyEvent event) {
            _handleKey(event);
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: (tapUpDetails) {
              // handle tap for mobile, may be nicer using keyboard keys on web
              _handleTap(tapUpDetails);
            },
            child: _getChildBasedOnGameState(),
          ),
        ),
    );
  }


  Widget _getChildBasedOnGameState() {
    Widget child;

    switch (_gameState) {
      case GameState.PLAYING:
        List<Positioned> gamePieces = List();
        gamePieces.add(Positioned(
          child: PlayerPiece(colour: _player.colour),
          left: _player.position.x * PLAYER_SIZE,
          top: _player.position.y * PLAYER_SIZE,
        ));

        _platforms.forEach((platform) {
          gamePieces.add(Positioned(
            child: platform.draw(),
            left: platform.position.x,
            top: platform.position.y,
          ));
        });

        child = Stack(children: gamePieces);
        break;

      case GameState.GAME_OVER:
        _timer.cancel();
        child = Text("Game Over..", style: TextStyle(color: Colors.greenAccent),);
        break;

    }

    return child;
  }
  

  void _onTimerTick(Timer timer) {
    _move();

    if (_isWallCollision()) {
      _changeGameState(GameState.GAME_OVER);
      return;
    }

    _player.falling = !_isPlatformCollision();
  }


  void _prepareStartGame() {
    print("prepare start");
    // add player
    _player = Player(colour: Colors.cyanAccent, position: _generateStartPosition());

    //generate level platform
    _platforms.add(Platform(colour: Colors.red, height: 20, width: 500, position: Point(200, 700)));
    _platforms.add(Platform(colour: Colors.blue, height: 20, width: 200, position: Point(700, 600)));

    _generateStartPosition();
    _changeGameState(GameState.PLAYING);
    _timer = Timer.periodic(Duration(milliseconds: 30), _onTimerTick);
  }


  bool _isWallCollision() {
    bool hasCollision = false;
    var currentPosition = _player.position;
    if (currentPosition.x < 0 || currentPosition.y < 0 || currentPosition.x > LEVEL_SIZE / PLAYER_SIZE || currentPosition.y > LEVEL_SIZE / PLAYER_SIZE) {
      hasCollision = true;
    }
    return hasCollision;
  }


  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  bool _isPlatformCollision() {
    bool hasCollision = false;
    _platforms.forEach((platform) {
      if (platform.contains(_player.position.x, _player.position.y)) {
        hasCollision = true;
      }
    });
    return hasCollision;
  }


  void _handleKey(RawKeyEvent event) {
    switch (_gameState) {
      case GameState.PLAYING:
        _changeDirectionBasedOnKey(event);
        break;
      case GameState.GAME_OVER:
        //todo handle this
        break;
    }
  }


  void _changeDirectionBasedOnKey(RawKeyEvent event) {

    print(event.logicalKey.keyId);

    switch(keyValues.map[event.logicalKey.keyId]) {
      case KeyboardPress.LEFT_ARROW:
        _player.moveLeft = event.runtimeType == RawKeyDownEvent;
        break;
      case KeyboardPress.RIGHT_ARROW:
        _player.moveRight = event.runtimeType == RawKeyDownEvent;
        break;
      case KeyboardPress.SPACE:
        _player.jump();
        break;
    }
  }


  void _handleTap(TapUpDetails tapUpDetails) {
    switch (_gameState) {
      case GameState.PLAYING:
        _changeDirectionBasedOnTap(tapUpDetails);
        break;
      case GameState.GAME_OVER:
        _prepareStartGame();
        break;
    }
  }


  void _changeDirectionBasedOnTap(TapUpDetails tapUpDetails) {
    //todo implement this
  }

  void _changeGameState(GameState gameState) {
    print(gameState);
    setState(() {
      _gameState = gameState;
    });
  }

  Point _generateStartPosition() {
    final midPoint = (LEVEL_SIZE / PLAYER_SIZE / 2);
    return Point(midPoint, midPoint);
  }

  void _move() {
    setState(() {
      _player.update();
    });
  }
}