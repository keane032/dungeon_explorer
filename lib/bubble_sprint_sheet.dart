import 'package:bonfire/bonfire.dart';

class BubbleSpritSheet {
  static get idleRigth => SpriteAnimation.load(
      'explorer/bubble.png',
      SpriteAnimationData.sequenced(
          amount: 4, stepTime: 0.1, textureSize: Vector2(16, 16)));

  static get runRigth => SpriteAnimation.load(
      'explorer/bubble.png',
      SpriteAnimationData.sequenced(
          amount: 4, stepTime: 0.1, textureSize: Vector2(16, 16)));

  static get idleUp => SpriteAnimation.load(
      'explorer/explorer_rigth.png',
      SpriteAnimationData.sequenced(
          amount: 4, stepTime: 0.1, textureSize: Vector2(16, 16)));

  static get idleDown => SpriteAnimation.load(
      'explorer/explorer_rigth.png',
      SpriteAnimationData.sequenced(
          amount: 4, stepTime: 0.1, textureSize: Vector2(16, 16)));

  static get idleBack => SpriteAnimation.load(
      'explorer/explorer_rigth.png',
      SpriteAnimationData.sequenced(
          amount: 4, stepTime: 0.1, textureSize: Vector2(16, 16)));

  static get receveAttackRigth => SpriteAnimation.load(
      'explorer/bubble_reciveAttack.png',
      SpriteAnimationData.sequenced(
          amount: 3, stepTime: 0.1, textureSize: Vector2(16, 16)));

  static get reciveAttackLeft => SpriteAnimation.load(
      'explorer/bubble.png',
      SpriteAnimationData.sequenced(
          amount: 1, stepTime: 0.1, textureSize: Vector2(16, 16)));
}
