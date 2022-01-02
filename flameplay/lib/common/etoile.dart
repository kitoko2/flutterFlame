import 'dart:math';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flameplay/main.dart';

class Etoile extends SpriteAnimationComponent with HasGameRef<GameManager> {
  @override
  Future<void>? onLoad() async {
    var spriteSheet = SpriteSheet(
      image: await Images(prefix: "assets/").load("stars.png"),
      srcSize: Vector2(9, 9),
    );

    animation = spriteSheet.createAnimation(
      row: Random().nextInt(3),
      stepTime: Random().nextDouble() + 0.2,
    );
    var taille = Random().nextInt(10) + 10;

    x = Random()
        .nextInt(gameRef.size.toSize().width.toInt() - taille)
        .toDouble();
    y = Random()
        .nextInt(gameRef.size.toSize().height.toInt() - taille)
        .toDouble();
    width = taille.toDouble();
    height = taille.toDouble();
    anchor = Anchor.center;
    return super.onLoad();
  }
}
