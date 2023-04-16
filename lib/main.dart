import 'package:bonfire/bonfire.dart';
import 'package:dungeon_explorer/bubble.dart';
import 'package:dungeon_explorer/explorer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const tileSize = 16;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.setPortraitUpOnly();
    await Flame.device.fullScreen();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(backgroundColor: Colors.black, body: Menu()),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Padding(
          padding: EdgeInsets.only(top: 200),
          child: Text(
            "Dungeon Explorer",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "8Bits",
                color: Colors.white,
                fontSize: 40,
                overflow: TextOverflow.visible),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        GestureDetector(
          onTap: (() => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Game()),
              )),
          child: const SizedBox(
            width: 100,
            height: 100,
            child: Text(
              "START",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "8Bits", color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}

class Game extends StatefulWidget {
  final int stage;
  const Game({Key? key, this.stage = 1}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> implements GameListener {
  bool showModal = false;

  List<SimpleEnemy> enimies = [];

  static _getTileSiPosition(int x, int y) {
    return Vector2(x * 16, y * 16);
  }

  @override
  void initState() {
    switch (widget.stage) {
      case 1:
        enimies.addAll([
          Bubble(position: _getTileSiPosition(7, 7), size: Vector2(16, 16)),
        ]);
        break;
      case 2:
        enimies.addAll([
          Bubble(position: _getTileSiPosition(7, 2), size: Vector2(16, 16)),
          Bubble(position: _getTileSiPosition(7, 7), size: Vector2(16, 16)),
        ]);
        break;
      default:
        enimies.addAll([
          Bubble(position: _getTileSiPosition(7, 2), size: Vector2(16, 16)),
          Bubble(position: _getTileSiPosition(2, 8), size: Vector2(16, 16)),
          Bubble(position: _getTileSiPosition(12, 11), size: Vector2(16, 16)),
          Bubble(position: _getTileSiPosition(18, 18), size: Vector2(16, 16)),
        ]);
        break;
    }
    super.initState();
  }

  Future<void> showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'congratulations',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: '8Bits', fontSize: 15),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Next Level',
                style: TextStyle(fontFamily: '8Bits'),
              ),
              onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Game(stage: widget.stage + 1)),
                  )),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BonfireTiledWidget(
      gameController: GameController()..addListener(this),
      components: [...enimies],
      joystick: Joystick(
          directional: JoystickDirectional(),
          keyboardConfig: KeyboardConfig(
              keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows),
          actions: [
            JoystickAction(
                actionId: 1, margin: const EdgeInsets.all(40), size: 70)
          ]),
      map: TiledWorldMap('city/map.json'),
      player:
          Explorer(position: _getTileSiPosition(15, 4), size: Vector2(16, 16)),
      cameraConfig: CameraConfig(
        moveOnlyMapArea: true,
        zoom: 4.5,
      ),
    );
  }

  @override
  void changeCountLiveEnemies(int count) {
    if (count == 0 && !showModal) {
      showMyDialog(context);
      setState(() {
        showModal = true;
      });
    }
  }

  @override
  void updateGame() {}
}
