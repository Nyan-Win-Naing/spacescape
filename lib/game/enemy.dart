import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:space_escape/game/bullet.dart';
import 'package:space_escape/game/game.dart';

class Enemy extends SpriteComponent with CollisionCallbacks {
  double _speed = 250;

  Enemy({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size) {
    angle = pi;
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += Vector2(0, 1) * _speed * dt;

    if(position.y > gameSize.y) {
      removeFromParent();
    }
  }

  @override
  void onMount() {
    super.onMount();
    final shape = CircleHitbox();
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if(other is Bullet) {
      removeFromParent();
    }
  }

  void removeEnemy() {
    removeFromParent();
  }


  @override
  void onRemove() {
    super.onRemove();
    print("Removing ${this.toString()}");
  }
}