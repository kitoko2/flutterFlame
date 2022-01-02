import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flameplay/common/enemy.dart';
import 'package:flameplay/main.dart';

class Missile extends SpriteComponent
    with HasGameRef<GameManager>, HasHitboxes, Collidable {
  HitboxRectangle hitboxRectangle = HitboxRectangle();
  Function? enemyToucher;

  Missile({this.enemyToucher});
  @override
  Future<void>? onLoad() async {
    sprite = Sprite(
      await Images(prefix: "assets/").load("bullet.png"),
    );
    size = sprite!.originalSize;

    anchor = Anchor.center;
    addHitbox(hitboxRectangle);
    return super.onLoad();
  }

  var speed = 200.0;
  @override
  void update(double dt) {
    position += Vector2(0, -1) * speed * dt;
    if (position.toSize().height < 0) {
      removeFromParent();
      removeHitbox(hitboxRectangle);
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Enemy) {
      removeFromParent();
      removeHitbox(hitboxRectangle);
      enemyToucher!.call(other.position);
    }
    super.onCollision(intersectionPoints, other);
  }
}
