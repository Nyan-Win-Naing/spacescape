import 'package:flutter/material.dart';
import 'package:space_escape/game/game.dart';
import 'package:space_escape/screens/main_menu.dart';
import 'package:space_escape/widget/overlays/pause_button.dart';

class GameOverMenu extends StatelessWidget {
  static const String id = "GameOverMenu";
  final SpaceEscapeGame gameRef;
  const GameOverMenu({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50,
            ),
            child: Text(
              "Game Over",
              style: TextStyle(
                fontSize: 50,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 20,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                gameRef.overlays.remove(GameOverMenu.id);
                gameRef.overlays.add(PauseButton.id);
                gameRef.reset();
                gameRef.resumeEngine();
              },
              child: Text(
                "Restart",
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                gameRef.overlays.remove(GameOverMenu.id);
                gameRef.reset();
                gameRef.resumeEngine();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainMenu(),
                  ),
                );
              },
              child: Text(
                "Exit",
              ),
            ),
          )
        ],
      ),
    );
  }
}
