import 'dart:math';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flameplay/common/missile.dart';
import 'package:flameplay/main.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameRef<GameManager>, HasHitboxes, Collidable {
  HitboxRectangle hitboxRectangle = HitboxRectangle();

  @override
  Future<void>? onLoad() async {
    var spriteSheet = SpriteSheet(
      image: await Images(prefix: "assets/").load("enemy.png"),
      srcSize: Vector2(16, 16),
    );
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1);
    var taille = 29.0;
    x = Random()
        .nextInt(gameRef.size.toSize().width.toInt() - taille.toInt())
        .toDouble();
    y = 10;
    width = taille;
    height = taille;
    anchor = Anchor.center;
    addHitbox(hitboxRectangle);
    return super.onLoad();
  }

  var speed = 200.0;

  @override
  void update(double dt) {
    position += Vector2(0, 1) * speed * dt;
    if (position.toSize().height > gameRef.size.y) {
      removeFromParent();
      removeHitbox(hitboxRectangle);
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Missile) {
      removeFromParent();
      removeHitbox(hitboxRectangle);
    }
    super.onCollision(intersectionPoints, other);
  }
}
