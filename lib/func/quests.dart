import 'dart:io';

import 'package:game_calendar/const/enum.dart';
import 'package:path_provider/path_provider.dart';

Future<Map> getQuests(int gameCode, int types) async {
  Map<String, dynamic> quests = {};
  await Storage(gameCode).readData().then((value) => quests = value);
  return quests;
}

Map<String, dynamic> getDefault(int gameCode, int types) {
  if (GameNames.values[gameCode] == GameNames.minecraft) {
    Map<String, List> quests = {
      'huntAnimal': ['동물 사냥', '50', true],
      'killEnemy': ['몬스터 사냥', '40', false],
      'fising': ['물고기 낚시', '20', true],
      'cutTree': ['나무 벌목', '500', false],
      'dig': ['바닥 파기', '500', true],
      'mining': ['암석 채광', '500', true],
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

class Storage {
  late int gameCode;

  Storage(int gameCode_) {
    gameCode = gameCode_;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    switch (GameNames.values[gameCode]) {
      case (GameNames.minecraft):
        return File('$path/quests_minecraft.txt');
      case (GameNames.lostark):
        return File('$path/quests_lostark.txt');
      default:
        return File('$path/quests_minecraft.txt');
    }
  }

  Future<Map<String, dynamic>> readData() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();
      Map<String, List> quests = {};

      List<String> questsList = contents.split(';');
      for (var quest in questsList) {
        if (quest.isEmpty) break;
        List<String> splitName = quest.split(':');
        List<String> splitDetails = splitName[1].split(',');
        List convertDetails = [
          splitDetails[0].trimLeft(),
          splitDetails[1].trimLeft(),
          splitDetails[2] == 'true' ? true : false
        ];
        quests[splitName[0]] = convertDetails;
      }
      return quests;
    } catch (e) {
      return {};
    }
  }

  Future<File> writeData(Map quests) async {
    final file = await _localFile;
    String data = '';
    print("저장 진입");

    quests.forEach((key, value) {
      String str = value.toString().replaceAll('[', '').replaceAll(']', '');
      data += key + ":" + str + ";";
    });
    print("저장 완료");
    print(data);
    return file.writeAsString(data);
  }

  void saveData(Map quests) async {
    Map<String, dynamic> quests_ = {};
    await Storage(gameCode).readData().then((value) => quests_ = value);
    Map<String, List> result = {};
    int index = 0;
    bool isChange = false;

    quests_.forEach((key, value) {
      if (isChange) {
        print("변환 X $index");
        result[index.toString()] = [
          value[0],
          value[1],
          value[2],
        ];
      } else {
        if ((quests['ctr1_'] == value[0]) &&
            (quests['ctr1_'] != quests['ctr1']) &&
            (quests['ctr2_'] == value[1]) &&
            (quests['toggle_'] == value[2])) {
          print("구분 변환 $index");
          isChange = true;
          result[index.toString()] = [
            quests['ctr1'],
            quests['ctr2'],
            quests['toggle'],
          ];
        } else if ((quests['ctr2_'] == value[1]) &&
            (quests['ctr2_'] != quests['ctr2']) &&
            (quests['ctr1_'] == value[0]) &&
            (quests['toggle_'] == value[2])) {
          print("상세 변환 $index");
          isChange = true;
          result[index.toString()] = [
            quests['ctr1'],
            quests['ctr2'],
            quests['toggle'],
          ];
        } else if ((quests['toggle_'] == value[2]) &&
            (quests['toggle_'] != quests['toggle']) &&
            (quests['ctr1_'] == value[0]) &&
            (quests['ctr2_'] == value[1])) {
          print("체크 변환 $index");
          isChange = true;
          result[index.toString()] = [
            quests['ctr1'],
            quests['ctr2'],
            quests['toggle'],
          ];
        } else {
          print("해당 없음 $index");
          result[index.toString()] = [
            value[0],
            value[1],
            value[2],
          ];
        }
      }
      index++;
    });
    print(quests_);
    print(quests);
    print(result);
    writeData(result);
  }
}
