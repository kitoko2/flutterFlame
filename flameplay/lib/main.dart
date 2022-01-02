// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flameplay/screen/gameScreen.dart';
import 'package:flameplay/screen/mainScreen.dart';
import "package:flutter/material.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameWidget(
        game: GameManager(),
        loadingBuilder: (c) {
          return Center(child: CircularProgressIndicator());
        },
      ),
      title: "startWars",
    );
  }
}

class GameManager extends FlameGame with PanDetector, HasCollidables {
  late MainScreen mainScreen;
  late GameScreen gameScreen;
  GameManager() {
    mainScreen = MainScreen(onTapped: () {
      gameScreen = GameScreen();
      remove(mainScreen);
      add(gameScreen);
    });
  }

  endGame(int score) {
    print(score);
    remove(gameScreen);
    add(mainScreen);
  }

  @override
  Future<void>? onLoad() {
    add(mainScreen);
    return super.onLoad();
  }

  @override
  void onPanStart(DragStartInfo info) {
    mainScreen.onPanUpdate(info);
    super.onPanStart(info);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    gameScreen.onPanUpdate(info);
    super.onPanUpdate(info);
  }
}
