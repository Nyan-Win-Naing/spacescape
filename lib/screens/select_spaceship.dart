import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:space_escape/models/player_data.dart';
import 'package:space_escape/models/spaceship_details.dart';
import 'package:space_escape/screens/game_play.dart';
import 'package:space_escape/screens/main_menu.dart';

class SelectSpaceship extends StatelessWidget {
  const SelectSpaceship({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
              ),
              child: Text(
                "Select",
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
            Consumer<PlayerData>(
              builder: (context, playerData, child) {
                final spaceship =
                    SpaceShip.getSpaceshipByType(playerData.spaceshipType);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Ship: ${spaceship.name}",
                    ),
                    Text(
                      "Money: ${playerData.money}",
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: CarouselSlider.builder(
                itemCount: SpaceShip.spaceships.length,
                slideBuilder: (index) {
                  final spaceship =
                      SpaceShip.spaceships.entries.elementAt(index).value;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        spaceship.assetPath,
                      ),
                      Text(
                        spaceship.name,
                      ),
                      Text(
                        "Speed: ${spaceship.speed}",
                      ),
                      Text(
                        "Level: ${spaceship.level}",
                      ),
                      Text(
                        "Cost: ${spaceship.cost}",
                      ),
                      Consumer<PlayerData>(
                        builder: (context, playerData, child) {
                          final type =
                              SpaceShip.spaceships.entries.elementAt(index).key;
                          final isEquipped = playerData.isEquipped(type);
                          final isOwned = playerData.isOwned(type);
                          final canBuy = playerData.canBuy(type);

                          return ElevatedButton(
                            onPressed: isEquipped
                                ? null
                                : () {
                                    if (isOwned) {
                                      playerData.equip(type);
                                    } else {
                                      if (canBuy) {
                                        playerData.buy(type);
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.red,
                                              title: Text(
                                                "Insufficient Balance",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Text(
                                                "Need ${spaceship.cost - playerData.money} more.",
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },
                            child: Text(isEquipped
                                ? "Equipped"
                                : isOwned
                                    ? "Select"
                                    : "Buy"),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePlay(),
                    ),
                  );
                },
                child: Text(
                  "Start",
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainMenu(),
                    ),
                  );
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
