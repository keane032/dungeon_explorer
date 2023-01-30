import 'package:bonfire/bonfire.dart';

class PlayerSpritSheet {
  static get idleRigth => SpriteAnimation.load(
      'explorer/personagem2.png',
      SpriteAnimationData.sequenced(
          amount: 1, stepTime: 0.1, textureSize: Vector2(16, 16)));

  static get runRigth => SpriteAnimation.load(
      'explorer/personagem2.png',
      SpriteAnimationData.sequenced(
          amount: 4, stepTime: 0.1, textureSize: Vector2(16, 16)));

  static get idleUp => SpriteAnimation.load(
      'explorer/personagem2.png',
      SpriteAnimationData.sequenced(
          amount: 4, stepTime: 0.1, textureSize: Vector2(16, 16)));

  static get idleDown => SpriteAnimation.load(
      'explorer/personagem2.png',
      SpriteAnimationData.sequenced(
          amount: 4, stepTime: 0.1, textureSize: Vector2(16, 16)));

  static get idleBack => SpriteAnimation.load(
      'explorer/personagem2.png',
      SpriteAnimationData.sequenced(
          amount: 4, stepTime: 0.1, textureSize: Vector2(16, 16)));
}
