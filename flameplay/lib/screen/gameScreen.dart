import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flameplay/common/background.dart';
import 'package:flameplay/common/enemy.dart';
import 'package:flameplay/common/explosion.dart';
import 'package:flameplay/common/missile.dart';
import 'package:flameplay/main.dart';
import 'package:flameplay/screen/player.dart';
import 'package:flutter/cupertino.dart';

class GameScreen extends Component
    with HasGameRef<GameManager>, WidgetsBindingObserver {
  int score = 0;
  Timer? timer;
  Timer? timerLanceMissile;
  double vitDebut = 1.5;

  late Player? player;
  GameScreen() {
    player = Player(endFunc: () {
      gameRef.endGame(score);
    });
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }

  @override
  Future<void>? onLoad() {
    WidgetsBinding.instance!.addObserver(this);
    timer = Timer(2, onTick: seeEnemy, repeat: true);
    timerLanceMissile = Timer(vitDebut, onTick: lanceMissile, repeat: true);
    add(BackGround(nbrEtoile: 50));
    add(player!);

    return super.onLoad();
  }

  seeEnemy() {
    for (var i = 0; i <= min((score ~/ 20), 2); i++) {
      add(Enemy());
    }
  }

  lanceMissile() {
    Missile missile = Missile(enemyToucher: (Vector2 pos) {
      Explosion explosion = Explosion();
      explosion.position = pos;
      add(explosion);
      score += 1;
    });
    missile.position = player!.position.clone();
    add(missile);
  }

  onPanUpdate(DragUpdateInfo info) {
    if (isMounted) {
      player!.move(info);
    }
  }

  @override
  void onMount() {
    timer!.start();
    timerLanceMissile!.start();
    super.onMount();
  }

  @override
  void onRemove() {
    timer!.stop();
    timerLanceMissile!.stop();
    super.onRemove();
  }

  @override
  void update(double dt) {
    timer!.update(dt);
    timerLanceMissile!.update(dt);
    super.update(dt);
  }
}
