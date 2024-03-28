import 'package:flutter/material.dart';
import 'package:game_calendar/const/colors.dart';
import 'package:game_calendar/const/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

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

class _HomeScreenState extends State<HomeScreen> {
  int game = 0;
  int type = 0;
  List<Widget> bodyScreen = List<Widget>.empty(growable: true);

  @override
  void initState() {
    bodyScreen = renderListView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 상단
              Expanded(
                flex: 15,
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        //게임 이름 선택시
                        //게임 이름 변경
                        if (game < GameNames.values.length - 1) {
                          game++;
                        } else {
                          game = 0;
                        }

                        //게임별 주요 단위 지정
                        if (GameNames.values[game] == GameNames.minecraft) {
                          type = Types.day.index;
                        } else if (GameNames.values[game] ==
                            GameNames.lostark) {
                          type = Types.week.index;
                        }
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          '게임 선택',
                          style: textStyle(20, Colors.black),
                        ),
                        Text(
                          GameNames.values[game].convert,
                          style: textStyle(30),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // 중앙 메인
              Expanded(
                flex: 75,
                child: ListView.builder(
                  itemBuilder: (context, index) => bodyScreen[index],
                  itemCount: bodyScreen.length,
                ),
              ),
              // 하단
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    Text(
                      '단위 구분',
                      style: textStyle(15, Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          //숙제 단위 선택시
                          if (type < Types.values.length - 1) {
                            type++;
                          } else {
                            type = 0;
                          }
                        });
                      },
                      child: Text(
                        Types.values[type].convert,
                        style: textStyle(15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> renderListView() {
    switch (game) {
      case 0:
        return loadMinecraft();
      case 1:
        return loadLostArk();
      default:
        return loadMinecraft();
    }
  }

  List<Widget> loadMinecraft([List<Widget>? list]) {
    List<Widget> result = List<Widget>.empty(growable: true);

    list?.forEach((widget) {
      result.add(widget);
    });

    Widget addContent() {
      bool toggle = false;
      Icon icon = Icon(Icons.check);
      return Container(
        color: secondaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('동물잡기 ${bodyScreen.length}'),
            IconButton(
              icon: icon == Icon(Icons.check)
                  ? Icon(Icons.check_box_outline_blank)
                  : Icon(Icons.check),
              onPressed: () {
                setState(() {
                  toggle = !toggle;
                  print(toggle);
                });
              },
            )
          ],
        ),
      );
    }

    result.add(
      Container(
        color: secondaryColor,
        child: IconButton(
          onPressed: () {
            setState(() {
              bodyScreen.insert(bodyScreen.length - 1, addContent());
            });
          },
          icon: const Icon(
            Icons.add,
            size: 50.0,
          ),
        ),
      ),
    );

    return result;
  }

  List<Widget> loadLostArk() {
    return List<Widget>.empty(growable: true);
  }
}
