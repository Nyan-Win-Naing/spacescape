import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_escape/game/game.dart';
import 'package:space_escape/widget/overlays/pause_button.dart';
import 'package:space_escape/widget/overlays/pause_menu.dart';

SpaceEscapeGame _spaceEscapeGame = SpaceEscapeGame();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: GameWidget(
          game: _spaceEscapeGame,
          initialActiveOverlays: [
            PauseButton.id,
          ],
          overlayBuilderMap: {
            PauseButton.id: (BuildContext context, SpaceEscapeGame gameRef) =>
                PauseButton(
                  gameRef: gameRef,
                ),
            PauseMenu.id: (BuildContext context, SpaceEscapeGame gameRef) =>
                PauseMenu(
                  gameRef: gameRef,
                ),
          },
        ),
      ),
    );
  }
}
