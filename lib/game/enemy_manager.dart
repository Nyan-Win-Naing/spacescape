import 'dart:async' as da;
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:space_escape/game/enemy.dart';
import 'package:space_escape/game/game.dart';

class EnemyManager extends Component with HasGameRef<SpaceEscapeGame> {
  late Timer timer;
  SpriteSheet spriteSheet;
  Vector2 screenSize;
  Random random = Random();

  EnemyManager({required this.spriteSheet, required this.screenSize}) : super() {
    timer = Timer(
      1,
      onTick: spawnEnemy,
      repeat: true,
    );
  }

  void spawnEnemy() {
    print("Spawn Enemy method worked");
    Vector2 initialSize = Vector2(64, 64);
    Vector2 position = Vector2(random.nextDouble() * gameSize.x, 0);
    position.clamp(Vector2.zero() + initialSize / 2, gameSize - initialSize / 2);
    Enemy enemy = Enemy(
      sprite: spriteSheet.getSpriteById(12),
      size: initialSize,
      position: position,
    );
    enemy.anchor = Anchor.center;
    gameRef.add(enemy);
  }

  @override
  void onMount() {
    super.onMount();
    timer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
  }
}
