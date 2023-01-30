import 'package:bonfire/bonfire.dart';
import 'package:dungeon_explorer/explorer_sprit_sheet.dart';

class Explorer extends SimplePlayer with ObjectCollision {
  Explorer({
    required Vector2 position,
    required Vector2 size,
  }) : super(
            position: position,
            size: size,
            speed: 70,
            animation: SimpleDirectionAnimation(
                idleRight: PlayerSpritSheet.idleRigth,
                runRight: PlayerSpritSheet.runRigth)) {
    setupCollision(CollisionConfig(collisions: [
      CollisionArea.rectangle(size: Vector2(10, 10), align: Vector2(3, 3))
    ]));
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  bool onCollision(GameComponent component, bool active) {
    return super.onCollision(component, active);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN && event.id == 1) {
      playAction();
    }
    super.joystickAction(event);
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    super.joystickChangeDirectional(event);
  }

  void _executeAttack() {
    simpleAttackMelee(damage: 20, size: Vector2(4, 4), sizePush: 16);
  }

  void playAction() {
    simpleAttackRange(
      animationRight: Sprite.load('explorer/bullet.png').toAnimation(),
      animationLeft: Sprite.load('explorer/bullet.png').toAnimation(),
      animationDown: Sprite.load('explorer/bullet.png').toAnimation(),
      animationUp: Sprite.load('explorer/bullet.png').toAnimation(),
      size: Vector2(4, 4),
      speed: 150,
      damage: 30,
    );
  }
}
