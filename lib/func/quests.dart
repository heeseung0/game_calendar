import 'package:game_calendar/const/enum.dart';

Map getQuests(int gameCode, int types) {
  Map quests = getDefault(gameCode, types);

  return quests;
}

Map getDefault(int gameCode, int types) {
  if (GameNames.values[gameCode] == GameNames.minecraft) {
    Map<String, List<String>> quests = {
      'huntAnimal': ['동물 사냥', '50'],
      'killEnemy': ['몬스터 사냥', '40'],
      'fising': ['물고기 낚시', '20'],
      'cutTree': ['나무 벌목', '500'],
      'dig': ['바닥 파기', '500'],
      'mining': ['암석 채광', '500'],
    };
    return quests;
  } else if (GameNames.values[gameCode] == GameNames.lostark) {
    Map<String, String> quests = {
      'baltan': '발탄',
      'Byakis': '비아키스',
      'Cookseyton': '쿠크세이튼',
      'Abrelshud': '아브렐슈드'
    };
    return quests;
  } else {
    return {};
  }
}
