import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flameplay/main.dart';

class Explosion extends SpriteAnimationComponent with HasGameRef<GameManager> {
  @override
  Future<void>? onLoad() async {
    var spriteSheet = SpriteSheet(
      image: await Images(prefix: "assets/").load("explosion.png"),
      srcSize: Vector2(32, 32),
    );
    animation = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.1,
      loop: false,
    );

    width = 37;
    height = 42;
    anchor = Anchor.center;
    animation!.onComplete = () {
      removeFromParent();
    };

    return super.onLoad();
  }
}
