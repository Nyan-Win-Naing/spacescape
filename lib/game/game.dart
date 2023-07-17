import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:space_escape/game/bullet.dart';
import 'package:space_escape/game/enemy.dart';
import 'package:space_escape/game/enemy_manager.dart';
import 'package:space_escape/game/player.dart';
import 'package:space_escape/game/shoot_button.dart';

late Vector2 gameSize;

class SpaceEscapeGame extends FlameGame
    with HasCollisionDetection, DragCallbacks, PanDetector, TapDetector {
  SpaceEscapeGame() {}

  Offset? _pointerStartPosition;
  Offset? _pointerCurrentPosition;
  late Player _player;
  late ShootButton shootButton;
  final double _joystickRadius = 60;
  final double _deadZoneRadius = 10;
  late SpriteSheet _spriteSheet;
  late EnemyManager _enemyManager;
  late JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    print("Canvas size is ====> $canvasSize");
    gameSize = size;
    await images.load("game_tilesheet.png");
    final joyStickBackground = await images.load("joystick_background.png");
    final joyStickKnob = await images.load("joystick_knob.png");
    final shootSprite = await images.load("shoot.png");
    _spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache("game_tilesheet.png"),
      columns: 8,
      rows: 6,
    );

    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          joyStickKnob,
        ),
        size: Vector2.all(60),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          joyStickBackground,
        ),
        size: Vector2.all(100),
      ),
      margin: const EdgeInsets.only(left: 16, bottom: 40),
    );
    add(joystick);

    _player = Player(
      joystick: joystick,
      sprite: _spriteSheet.getSpriteById(4),
      size: Vector2(64, 64),
      position: canvasSize / 2,
    );
    _player.anchor = Anchor.center;
    add(_player);


    shootButton = ShootButton(
      player: _player,
      spriteSheet: _spriteSheet,
      sprite: Sprite(
        shootSprite,
      ),
      size: Vector2(70, 70),
      position: Vector2(canvasSize.x - 50, canvasSize.y - 50),
    );
    shootButton.anchor = Anchor.center;
    add(shootButton);

    _enemyManager = EnemyManager(spriteSheet: _spriteSheet, screenSize: size);
    add(_enemyManager);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (_pointerStartPosition != null) {
      canvas.drawCircle(
        _pointerStartPosition!,
        _joystickRadius,
        Paint()..color = Colors.grey.withAlpha(100),
      );
    }

    if (_pointerCurrentPosition != null) {
      var delta = _pointerCurrentPosition! - _pointerStartPosition!;
      print("Delta is $delta");
      if (delta.distance > _joystickRadius) {
        delta = _pointerStartPosition! +
            (Vector2(delta.dx, delta.dy).normalized() * _joystickRadius)
                .toOffset();
        print("Delta =======> $delta");
      } else {
        delta = _pointerCurrentPosition!;
      }
      print("Pointer is ====> $delta");

      canvas.drawCircle(
        delta,
        20,
        Paint()..color = Colors.white.withAlpha(100),
      );
    }
  }

  // @override
  // void onPanStart(DragStartInfo info) {
  //   print("On Pan Start");
  //   _pointerStartPosition = info.raw.globalPosition;
  //   _pointerCurrentPosition = info.raw.globalPosition;
  //   super.onPanStart(info);
  // }
  //
  // @override
  // void onPanCancel() {
  //   // _pointerStartPosition = null;
  //   // _pointerCurrentPosition = null;
  //   // player.setMoveDirection(Vector2.zero());
  //   super.onPanCancel();
  // }
  //
  // @override
  // void onPanEnd(DragEndInfo info) {
  //   // _pointerStartPosition = null;
  //   // _pointerCurrentPosition = null;
  //   // player.setMoveDirection(Vector2.zero());
  //   super.onPanEnd(info);
  // }
  //
  // @override
  // void onPanUpdate(DragUpdateInfo info) {
  //   super.onPanUpdate(info);
  //   if (joystick.knob?.contains(info.raw.globalPosition) ?? false) {
  //     // Update the knob position to the drag position
  //     joystick.updateKnobPosition(details.globalPosition);
  //   }
  //   // _pointerCurrentPosition = info.raw.globalPosition;
  //   // var delta = _pointerCurrentPosition! - _pointerStartPosition!;
  //   // if (delta.distance > _deadZoneRadius) {
  //   //   player.setMoveDirection(Vector2(delta.dx, delta.dy));
  //   // } else {
  //   //   player.setMoveDirection(Vector2.zero());
  //   // }
  // }
  //
  // @override
  // void onGameResize(Vector2 size) {
  //   super.onGameResize(size);
  // }

  @override
  Future<void> add(Component component) async {
    super.add(component);
  }

  // @override
  // void onTapDown(TapDownInfo info) {
  //   super.onTapDown(info);
  //
  //   // Bullet bullet = Bullet(
  //   //   sprite: _spriteSheet.getSpriteById(28),
  //   //   size: Vector2(64, 64),
  //   //   position: player.position,
  //   // );
  //   //
  //   // bullet.anchor = Anchor.center;
  //   // add(bullet);
  // }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  //
  //   print("Update method worked");
  //   final bullets = children.whereType<Bullet>();
  //
  //   for (final enemy in children.whereType<EnemyManager>().first.children.whereType<Enemy>()) {
  //     if (enemy.isRemoved) {
  //       continue;
  //     }
  //     for (final bullet in bullets) {
  //       if (bullet.isRemoved) {
  //         continue;
  //       }
  //       print("Status =====> ${enemy.containsPoint(bullet.absoluteCenter)}");
  //       if (enemy.containsPoint(bullet.absoluteCenter)) {
  //         enemy.removeEnemy();
  //         bullet.removeFromParent();
  //         break;
  //       }
  //     }
  //     if(player.containsPoint(enemy.absoluteCenter)) {
  //       print("Enemy hit player!!!");
  //     }
  //   }
  // }
}
