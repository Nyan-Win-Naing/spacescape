import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';



class MyGame extends FlameGame with DragCallbacks {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final image = await images.load('game_tilesheet.png');

    final joyStickBackground = await images.load("joystick_background.png");
    final joyStickKnob = await images.load("joystick_knob.png");
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 8,
      rows: 6,
    );
    final joystick = JoystickComponent(
      knob: CircleComponent(
        radius: 30,
        paint: BasicPalette.white.paint(),
      ),
      background: CircleComponent(
        radius: 50,
        paint: BasicPalette.gray.paint(),
      ),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    final player = JoystickPlayer(joystick);
    add(player);
    add(joystick);
  }

}

class JoystickPlayer extends SpriteComponent with HasGameRef {
  JoystickPlayer(this.joystick)
      : super(
          anchor: Anchor.center,
          size: Vector2.all(100.0),
        );

  /// Pixels/s
  double maxSpeed = 300.0;

  final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('shoot.png');
    position = gameRef.size / 2;
  }

  @override
  void update(double dt) {
    if (joystick.direction != JoystickDirection.idle) {
      position.add(joystick.delta * maxSpeed * dt);
      angle = joystick.delta.screenAngle();
    }
  }
}
