import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:space_escape/game/enemy.dart';
import 'package:space_escape/game/game.dart';

class Player extends SpriteComponent
    with CollisionCallbacks, HasGameRef<SpaceEscapeGame> {
  Vector2 _moveDirection = Vector2.zero();
  final JoystickComponent joystick;

  double _speed = 300;

  Random _random = Random();

  Vector2 getRandomVector() {
    return (Vector2.random(_random) - Vector2(0.5, -1)) * 200;
  }

  Player({
    required this.joystick,
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
    if (other is Enemy) {}
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _moveDirection.normalized() * _speed * dt;
    position.clamp(Vector2.zero() + size / 2, gameSize - size / 2);

    print("Joystick direction is ====> ${joystick.direction}");
    print("Joystick drag is =====> ${joystick.isDragged}");

    final particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        count: 10,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          acceleration: getRandomVector(),
          speed: getRandomVector(),
          position: Vector2(size.x / 2, size.y - 10),
          child: CircleParticle(
            radius: 1,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );
    add(particleComponent);

    switch (joystick.direction) {
      case JoystickDirection.up:
        setMoveDirection(Vector2(0, -1));
        break;
      case JoystickDirection.upLeft:
        setMoveDirection(Vector2(-1, -1));
        break;
      case JoystickDirection.upRight:
        setMoveDirection(Vector2(1, -1));
        break;
      case JoystickDirection.down:
        setMoveDirection(Vector2(0, 1));
        break;
      case JoystickDirection.downLeft:
        setMoveDirection(Vector2(-1, 1));
        break;
      case JoystickDirection.downRight:
        setMoveDirection(Vector2(1, 1));
        break;
      case JoystickDirection.left:
        setMoveDirection(Vector2(-1, 0));
        break;
      case JoystickDirection.right:
        setMoveDirection(Vector2(1, 0));
        break;
      case JoystickDirection.idle:
      setMoveDirection(Vector2.zero());
        break;
      default:
        break;
    }
  }

  void setMoveDirection(Vector2 newMoveDirection) {
    _moveDirection = newMoveDirection;
  }
}
