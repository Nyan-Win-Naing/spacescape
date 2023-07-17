// import 'dart:ui';
//
// import 'package:flame/components.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// class DraggableJoystickComponent extends JoystickComponent {
//   bool _dragging = false;
//
//   DraggableJoystickComponent({
//     required SpriteComponent background,
//     double size = 100,
//     EdgeInsets margin = EdgeInsets.zero,
//   }) : super(
//     knob: knob,
//     background: background,
//     size: size,
//     margin: margin,
//   );
//
//   Rect get knobRect => Rect.fromCenter(
//     center: position.toOffset(),
//     width: 30,
//     height: 30,
//   );
//
//   @override
//   void onGameResize(Vector2 gameSize) {
//     // Adjust the position of the joystick to the center of the screen
//     position = gameSize / 2;
//   }
//
//   @override
//   void render(Canvas canvas) {
//     // Only render the joystick if it is being dragged
//     if (_dragging) {
//       super.render(canvas);
//     }
//   }
//
//   @override
//   bool onTapDown(TapDownDetails details) {
//     // Check if the joystick knob is pressed
//     if (.contains(details.globalPosition)) {
//       // Start dragging
//       _dragging = true;
//       return true;
//     }
//     return false;
//   }
//
//   @override
//   bool onTapUp(TapUpDetails details) {
//     // Stop dragging
//     _dragging = false;
//     return true;
//   }
//
//   @override
//   bool onTapCancel() {
//     // Stop dragging
//     _dragging = false;
//     return true;
//   }
//
//   @override
//   bool onPanUpdate(DragUpdateDetails details) {
//     // Update the knob position if dragging is in progress
//     if (_dragging) {
//       updateKnobPosition(details.globalPosition);
//       return true;
//     }
//     return false;
//   }
//
//   @override
//   bool onPanEnd(DragEndDetails details) {
//     // Stop dragging
//     _dragging = false;
//     resetKnobPosition();
//     return true;
//   }
// }