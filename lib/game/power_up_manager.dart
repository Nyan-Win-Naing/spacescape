import 'dart:math';

import 'package:flame/components.dart';
import 'package:space_escape/game/enemy.dart';
import 'package:space_escape/game/game.dart';
import 'package:space_escape/game/power_ups.dart';

enum PowerUpTypes {
  Health,
  Freeze,
  Nuke,
  MultiFire,
}

class PowerUpManager extends Component with HasGameRef<SpaceEscapeGame> {
  late Timer spawnTimer;
  late Timer _freezeTimer;
  Vector2 screenSize;
  Random random = Random();

  static Map<PowerUpTypes, PowerUp Function(Vector2 position, Vector2 size)>
      _powerUpManager = {
    PowerUpTypes.Health: (position, size) =>
        Health(position: position, size: size),
    PowerUpTypes.Freeze: (position, size) =>
        Freeze(position: position, size: size),
    PowerUpTypes.Nuke: (position, size) => Nuke(position: position, size: size),
    PowerUpTypes.MultiFire: (position, size) =>
        MultiFire(position: position, size: size),
  };

  PowerUpManager({required this.screenSize}) : super() {
    spawnTimer = Timer(
      5,
      onTick: spawnPowerUp,
      repeat: true,
    );

    _freezeTimer = Timer(2, onTick: () {
      spawnTimer.start();
    });
  }

  void spawnPowerUp() {
    print("Spawn Enemy method worked");
    Vector2 initialSize = Vector2(64, 64);
    Vector2 position = Vector2(
      random.nextDouble() * gameSize.x,
      random.nextDouble() * gameSize.y,
    );
    position.clamp(
        Vector2.zero() + initialSize / 2, gameSize - initialSize / 2);

    int randomIndex = random.nextInt(PowerUpTypes.values.length);
    final fn = _powerUpManager[PowerUpTypes.values.elementAt(randomIndex)];

    var powerUp = fn?.call(position, initialSize);
    powerUp?.anchor = Anchor.center;
    if (powerUp != null) {
      gameRef.add(powerUp);
    }
  }

  @override
  void onMount() {
    super.onMount();
    spawnTimer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    spawnTimer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    spawnTimer.update(dt);
    _freezeTimer.update(dt);
  }

  void reset() {
    spawnTimer.stop();
    spawnTimer.start();
  }

  void freeze() {
    spawnTimer.stop();
    _freezeTimer.stop();
    _freezeTimer.start();
  }
}
