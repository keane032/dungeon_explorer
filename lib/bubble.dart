import 'package:bonfire/bonfire.dart';
import 'package:dungeon_explorer/bubble_sprint_sheet.dart';
import 'package:flutter/material.dart';

class Bubble extends SimpleEnemy with ObjectCollision, AutomaticRandomMovement {
  Bubble({required Vector2 position, required Vector2 size})
      : super(
            position: position,
            size: size,
            speed: 40,
            animation: SimpleDirectionAnimation(
                idleRight: BubbleSpritSheet.idleRigth,
                runRight: BubbleSpritSheet.runRigth)) {
    setupCollision(
      CollisionConfig(collisions: [
        CollisionArea.rectangle(size: Vector2(12, 12), align: Vector2(3, 3))
      ]),
    );
  }
  @override
  void update(double dt) {
    seeAndMoveToPlayer(
        closePlayer: (player) {
          // simpleAttackMelee(damage: 10000, size: Vector2(16, 16));
        },
        notObserved: () {
          runRandomMovement(dt);
        },
        radiusVision: 16 * 2,
        margin: 4);
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    drawDefaultLifeBar(canvas,
        borderWidth: 2,
        borderColor: Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(5)));
    super.render(canvas);
  }

  @override
  void die() {
    removeFromParent();
    super.die();
  }

  @override
  void receiveDamage(double damage, from) {
    if (lastDirectionHorizontal == Direction.right) {
      animation?.playOnce(BubbleSpritSheet.receveAttackRigth,
          runToTheEnd: true);
    } else {
      animation?.playOnce(BubbleSpritSheet.receveAttackRigth,
          runToTheEnd: true);
    }
    super.receiveDamage(damage, from);
  }
}
