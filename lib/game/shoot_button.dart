import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:space_escape/game/bullet.dart';
import 'package:space_escape/game/game.dart';
import 'package:space_escape/game/player.dart';

class ShootButton extends SpriteComponent with TapCallbacks, HasGameRef<SpaceEscapeGame> {

  final SpriteSheet spriteSheet;
  final SpriteComponent player;

  ShootButton({
    required this.player,
    required this.spriteSheet,
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);


  @override
  void onTapDown(TapDownEvent event) {
    Bullet bullet = Bullet(
      sprite: spriteSheet.getSpriteById(28),
      size: Vector2(64, 64),
      position: player.position,
    );

    bullet.anchor = Anchor.center;
    gameRef.add(bullet);

    if((player as Player).shootMultipleBullet) {
      for(int i = -1; i < 2; i +=2) {
        Bullet bullet = Bullet(
          sprite: spriteSheet.getSpriteById(28),
          size: Vector2(64, 64),
          position: player.position,
        );

        bullet.anchor = Anchor.center;
        bullet.direction.rotate(i * pi / 6);
        gameRef.add(bullet);
      }
    }
  }
}