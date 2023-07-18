import 'package:flutter/material.dart';
import 'package:space_escape/game/game.dart';
import 'package:space_escape/widget/overlays/pause_menu.dart';

class PauseButton extends StatelessWidget {
  static const String id = "PauseButton";
  final SpaceEscapeGame gameRef;

  const PauseButton({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: TextButton(
        onPressed: () {
          gameRef.pauseEngine();
          gameRef.overlays.add(PauseMenu.id);
          gameRef.overlays.remove(PauseButton.id);
        },
        child: Icon(
          Icons.pause_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
