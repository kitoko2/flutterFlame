import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flameplay/common/enemy.dart';
import 'package:flameplay/main.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<GameManager>, HasHitboxes, Collidable {
  HitboxRectangle hitboxRectangle = HitboxRectangle();
  Function? endFunc;
  Player({this.endFunc});
  @override
  Future<void>? onLoad() async {
    var spriteSheet = SpriteSheet(
      image: await Images(prefix: "assets/").load("player.png"),
      srcSize: Vector2(32, 48),
    );
    animation = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.1,
    );

    position = gameRef.size / 2;
    width = 37;
    height = 42;
    anchor = Anchor.center;
    addHitbox(hitboxRectangle);
    return super.onLoad();
  }

  move(DragUpdateInfo info) {
    position.add(info.delta.game);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Enemy) {
      endFunc!.call();
    }
    super.onCollision(intersectionPoints, other);
  }
}
