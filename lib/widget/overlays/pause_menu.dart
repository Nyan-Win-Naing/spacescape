import 'package:flutter/material.dart';
import 'package:space_escape/game/game.dart';
import 'package:space_escape/screens/main_menu.dart';
import 'package:space_escape/widget/overlays/pause_button.dart';

class PauseMenu extends StatelessWidget {
  static const String id = "PauseMenu";
  final SpaceEscapeGame gameRef;
  const PauseMenu({
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
              "Paused",
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
                gameRef.resumeEngine();
                gameRef.overlays.remove(PauseMenu.id);
                gameRef.overlays.add(PauseButton.id);
              },
              child: Text(
                "Resume",
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.id);
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
                gameRef.overlays.remove(PauseMenu.id);
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
