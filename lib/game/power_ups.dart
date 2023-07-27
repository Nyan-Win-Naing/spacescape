import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_escape/game/command.dart';
import 'package:space_escape/game/enemy.dart';
import 'package:space_escape/game/enemy_manager.dart';
import 'package:space_escape/game/game.dart';
import 'package:space_escape/game/player.dart';
import 'package:space_escape/game/power_up_manager.dart';

abstract class PowerUp extends SpriteComponent
    with HasGameRef<SpaceEscapeGame>, CollisionCallbacks {
  late Timer _timer;

  Sprite getSprite();
  void onActivated();

  PowerUp({
    Vector2? position,
    Vector2? size,
    Sprite? sprite,
  }) : super(
          position: position,
          size: size,
          sprite: sprite,
        ) {
    _timer = Timer(5, onTick: () {
      removeFromParent();
    });
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  @override
  void onMount() {
    final shape = CircleHitbox();
    add(shape);

    sprite = getSprite();

    _timer.start();
    super.onMount();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      onActivated();
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}

class Nuke extends PowerUp {
  Nuke({
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position,
          size: size,
        );

  @override
  Sprite getSprite() {
    return Sprite(
      gameRef.images.fromCache("nuke.png"),
    );
  }

  @override
  void onActivated() {
    final command = Command<Enemy>(
      action: (enemy) {
        enemy.destroy();
      },
    );
    gameRef.addCommand(command);
  }
}

class Health extends PowerUp {
  Health({
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position,
          size: size,
        );

  @override
  Sprite getSprite() {
    return Sprite(
      gameRef.images.fromCache("icon_plus_small.png"),
    );
  }

  @override
  void onActivated() {
    final command = Command<Player>(
      action: (player) {
        player.increaseHealthBy(10);
      },
    );
    gameRef.addCommand(command);
  }
}

class Freeze extends PowerUp {
  Freeze({
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position,
          size: size,
        );

  @override
  Sprite getSprite() {
    return Sprite(
      gameRef.images.fromCache("freeze.png"),
    );
  }

  @override
  void onActivated() {
    final command1 = Command<Enemy>(
      action: (enemy) {
        enemy.freeze();
      },
    );

    final command2 = Command<EnemyManager>(
      action: (enemyManager) {
        enemyManager.freeze();
      },
    );

    final command3 = Command<PowerUpManager>(
      action: (powerUpManager) {
        powerUpManager.freeze();
      },
    );
    gameRef.addCommand(command1);
    gameRef.addCommand(command2);
    gameRef.addCommand(command3);
  }
}

class MultiFire extends PowerUp {
  MultiFire({
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position,
          size: size,
        );

  @override
  Sprite getSprite() {
    return Sprite(
      gameRef.images.fromCache("multi_fire.png"),
    );
  }

  @override
  void onActivated() {
    final command = Command<Player>(
      action: (player) {
        player.shootMultipleBullets();
      },
    );

    gameRef.addCommand(command);
  }
}
