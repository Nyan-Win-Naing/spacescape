import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_escape/game/enemy.dart';
import 'package:space_escape/game/game.dart';

class Player extends SpriteComponent with CollisionCallbacks {
  Vector2 _moveDirection = Vector2.zero();

  double _speed = 300;

  Player({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  @override
  void onMount() {
    super.onMount();
    final shape = CircleHitbox();
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if(other is Enemy) {
      print("Player hit enemy");
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _moveDirection.normalized() * _speed * dt;
    position.clamp(Vector2.zero() + size / 2, gameSize - size / 2);
  }

  void setMoveDirection(Vector2 newMoveDirection) {
    _moveDirection = newMoveDirection;
  }

}
