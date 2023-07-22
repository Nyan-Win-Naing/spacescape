import 'package:flutter/foundation.dart';
import 'package:space_escape/models/spaceship_details.dart';

class PlayerData extends ChangeNotifier {
  SpaceshipType spaceshipType;
  final List<SpaceshipType> ownedSpaceships;
  final int highScore;
  int money;

  PlayerData({
    required this.spaceshipType,
    required this.ownedSpaceships,
    required this.highScore,
    required this.money,
  });

  PlayerData.fromMap(Map<String, dynamic> map)
      : spaceshipType = map["currentSpaceshipType"] as SpaceshipType,
        ownedSpaceships = (map["ownedSpaceshipTypes"] as List<dynamic>)
            .map((e) => e as SpaceshipType)
            .toList(),
        highScore = map["highScore"],
        money = map["money"];

  static Map<String, dynamic> defaultData = {
    "currentSpaceshipType": SpaceshipType.canary,
    "ownedSpaceshipTypes": [],
    "highScore": 0,
    "money": 500,
  };

  bool isOwned(SpaceshipType spaceshipType) {
    return ownedSpaceships.contains(spaceshipType);
  }

  bool canBuy(SpaceshipType spaceshipType) {
    return (money >= SpaceShip.getSpaceshipByType(spaceshipType).cost);
  }

  bool isEquipped(SpaceshipType spaceshipType) {
    print("Is equipped method worked");
    return this.spaceshipType == spaceshipType;
  }

  void buy(SpaceshipType spaceshipType) {
    if(canBuy(spaceshipType) && (!isOwned(spaceshipType))) {
      money -= SpaceShip.getSpaceshipByType(spaceshipType).cost;
      ownedSpaceships.add(spaceshipType);
      notifyListeners();
    }
  }

  void equip(SpaceshipType spaceshipType) {
    this.spaceshipType = spaceshipType;
    notifyListeners();
  }
}
