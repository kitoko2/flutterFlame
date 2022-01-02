import 'package:flame/components.dart';
import 'package:flameplay/common/etoile.dart';

class BackGround extends SpriteAnimationComponent {
  int? nbrEtoile;
  BackGround({this.nbrEtoile});
  @override
  Future<void>? onLoad() {
    for (var i = 0; i < nbrEtoile!; i++) {
      add(Etoile());
    }
    return super.onLoad();
  }
}
