import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flameplay/main.dart';

class MyText extends SpriteComponent with HasGameRef<GameManager> {
  @override
  Future<void>? onLoad() async {
    sprite = Sprite(
      await Images(prefix: "assets/").load("tap.png"),
    );
    anchor = Anchor.center;
    position = gameRef.size / 2;
    var ratio = sprite!.image.width / sprite!.image.height; //ratio
    width = sprite!.image.width / 2;
    height = width / ratio;

    return super.onLoad();
  }
}
