import 'package:flame/components.dart';
import 'package:flameplay/common/background.dart';
import 'package:flameplay/common/text.dart';
import 'package:flameplay/main.dart';

class MainScreen extends Component with HasGameRef<GameManager> {
  Function? onTapped;
  MainScreen({this.onTapped});
  @override
  Future<void>? onLoad() {
    add(BackGround(nbrEtoile: 40));
    add(MyText());
    return super.onLoad();
  }

  void onPanUpdate(info) {
    if (isMounted) onTapped!.call();
  }
}
