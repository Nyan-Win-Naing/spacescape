import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:space_escape/game/bullet.dart';
import 'package:space_escape/game/command.dart';
import 'package:space_escape/game/game.dart';
import 'package:space_escape/game/player.dart';

class Enemy extends SpriteComponent
    with CollisionCallbacks, HasGameRef<SpaceEscapeGame> {
  double _speed = 250;

  late Timer _freezeTimer;

  Enemy({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size) {
    angle = pi;
    _freezeTimer = Timer(
      2,
      onTick: () {
        _speed = 250;
      },
    );
  }

  Random _random = Random();

  Vector2 getRandomVector() {
    return (Vector2.random(_random) - Vector2.random(_random)) * 500;
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += Vector2(0, 1) * _speed * dt;

    if (position.y > gameSize.y) {
      removeFromParent();
    }

    _freezeTimer.update(dt);

    // final particleComponent = ParticleSystemComponent(
    //   particle: Particle.generate(
    //     count: 10,
    //     lifespan: 0.1,
    //     generator: (i) => AcceleratedParticle(
    //       acceleration: getRandomVector(),
    //       speed: getRandomVector(),
    //       position: Vector2(size.x / 2, size.y / 2),
    //       child: CircleParticle(
    //         radius: 1,
    //         paint: Paint()..color = Colors.white,
    //       ),
    //     ),
    //   ),
    // );
    // add(particleComponent);
  }

  @override
  void onMount() {
    super.onMount();
    final shape = CircleHitbox();
    add(shape);
  }

  void destroy() {
    final particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        count: 10,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          acceleration: getRandomVector(),
          speed: getRandomVector(),
          position: position.clone(),
          child: CircleParticle(
            radius: 1.5,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );
    gameRef.add(particleComponent);
    removeFromParent();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Bullet || other is Player) {
      removeFromParent();

      // gameRef.player.score += 1;
      final command = Command<Player>(
        action: (player) {
          player.addToScore(1);
        },
      );
      gameRef.addCommand(command);

      final particleComponent = ParticleSystemComponent(
        particle: Particle.generate(
          count: 10,
          lifespan: 0.1,
          generator: (i) => AcceleratedParticle(
            acceleration: getRandomVector(),
            speed: getRandomVector(),
            position: position.clone(),
            child: CircleParticle(
              radius: 1.5,
              paint: Paint()..color = Colors.white,
            ),
          ),
        ),
      );
      gameRef.add(particleComponent);
    }
  }

  void removeEnemy() {
    removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onRemove() {
    super.onRemove();
    print("Removing ${this.toString()}");
  }

  void freeze() {
    _speed = 0;
    _freezeTimer.stop();
    _freezeTimer.start();
  }
}
