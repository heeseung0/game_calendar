enum GameNames<int> { minecraft, lostark }

enum Types<int> { day, week }

extension GameNamesExtension on GameNames {
  String get convert {
    switch (this) {
      case GameNames.minecraft:
        return '마인크래프트';
      case GameNames.lostark:
        return '로스트아크';
      default:
        return '마인크래프트';
    }
  }
}

extension TypesExtension on Types {
  String get convert {
    switch (this) {
      case Types.day:
        return '일일';
      case Types.week:
        return '주간';
      default:
        return '일일';
    }
  }
}
