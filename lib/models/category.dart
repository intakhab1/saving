import 'package:hive/hive.dart';
import 'package:saving/common/theme/theme.dart';

part 'category.g.dart';

@HiveType(typeId: 0)
class Category {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String icon;

  @HiveField(2)
  final int color;

  Category(this.name, this.icon, this.color);

  static Category get electronic {
    return Category(
      "Electronic",
      "assets/svg/ic_electronic.svg",
      blueColor.value,
    );
  }

  static Category get building {
    return Category(
      "Building",
      "assets/svg/ic_building.svg",
      blueColor.value,
    );
  }

  static Category get vehicle {
    return Category(
      "Vehicle",
      "assets/svg/ic_vehicle.svg",
      blueColor.value,
    );
  }

  static Category get clothes {
    return Category(
      "Clothes",
      "assets/svg/ic_clothes.svg",
      yellowColor.value,
    );
  }

  static Category get travel {
    return Category(
      "Journey",
      "assets/svg/ic_travel.svg",
      blueColor.value,
    );
  }

  static Category get education {
    return Category(
      "Education",
      "assets/svg/ic_education.svg",
      yellowColor.value,
    );
  }

  static Category get food {
    return Category(
      "Food",
      "assets/svg/ic_food.svg",
      yellowColor.value,
    );
  }

  static Category get health {
    return Category(
      "Health",
      "assets/svg/ic_health.svg",
      pinkColor.value,
    );
  }

  static Category get game {
    return Category(
      "Game",
      "assets/svg/ic_game.svg",
      yellowColor.value,
    );
  }

  static Category get pet {
    return Category(
      "Pet",
      "assets/svg/ic_pet.svg",
      pinkColor.value,
    );
  }

  static Category get gift {
    return Category(
      "Gifts",
      "assets/svg/ic_gift.svg",
      pinkColor.value,
    );
  }

  static Category get care {
    return Category(
      "Maintenance",
      "assets/svg/ic_care.svg",
      pinkColor.value,
    );
  }

  static Category get sport {
    return Category(
      "Sports",
      "assets/svg/ic_sport.svg",
      yellowColor.value,
    );
  }

  static Category get entertainment {
    return Category(
      "Entertainment",
      "assets/svg/ic_entertainment.svg",
      yellowColor.value,
    );
  }

  static Category get accessories {
    return Category(
      "Accessories",
      "assets/svg/ic_accessories.svg",
      pinkColor.value,
    );
  }

  static Category get other {
    return Category(
      "Other",
      "assets/svg/ic_other.svg",
      blueColor.value,
    );
  }
}
