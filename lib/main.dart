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
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> implements GameListener {
  bool showModal = false;

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
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                // Text(
                //   'congratulations',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(fontFamily: '8Bits', fontSize: 15),
                // )
              ],
            ),
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
                    MaterialPageRoute(builder: (context) => const Game()),
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
      joystick: Joystick(directional: JoystickDirectional(), actions: [
        JoystickAction(actionId: 1, margin: const EdgeInsets.all(40), size: 70)
      ]),
      map: TiledWorldMap('city/map.json', objectsBuilder: {
        'bubble': ((properties) =>
            Bubble(position: properties.position, size: properties.size))
      }),
      player:
          Explorer(position: Vector2(11 * 16, 11 * 16), size: Vector2(16, 16)),
      cameraConfig: CameraConfig(
        moveOnlyMapArea: true,
        zoom: 2.5,
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
