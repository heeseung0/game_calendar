import 'package:flutter/material.dart';
import 'package:game_calendar/const/colors.dart';
import 'package:game_calendar/const/dummy.dart';
import 'package:game_calendar/const/enum.dart';
import 'package:game_calendar/const/style.dart';
import 'package:game_calendar/func/quests.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int game = 0;
  int type = 0;
  List<Widget> bodyScreen = List<Widget>.empty(growable: true);

  @override
  void initState() {
    renderListView();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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

                        renderListView();
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          '게임 선택',
                          style: textStyle(20, Colors.black, FontWeight.bold),
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
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: Text('구분',
                                style: textStyle(
                                    22, Colors.black, FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text('상세',
                                style: textStyle(
                                    22, Colors.black, FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text('체크',
                                style: textStyle(
                                    22, Colors.black, FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 95,
                      child: ListView.builder(
                        itemBuilder: (context, index) => bodyScreen[index],
                        itemCount: bodyScreen.length,
                      ),
                    ),
                  ],
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

  void renderListView() {
    switch (game) {
      case 0:
        loadMinecraft();
        break;
      case 1:
        loadLostArk();
        break;
      default:
        loadMinecraft();
        break;
    }
  }

  void loadMinecraft([List<Widget>? list]) {
    List<Widget> result = List<Widget>.empty(growable: true);

    list?.forEach((widget) {
      result.add(widget);
    });

    Widget addContent([String? quest, String? cnt, bool? toggle]) {
      bool toggle_ = toggle ?? false;
      Icon icon = toggle_
          ? const Icon(Icons.check)
          : const Icon(Icons.check_box_outline_blank);

      return Container(
        color: secondaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: TextButton(
                child: TextFormField(
                  initialValue: quest ?? '퀘스트 목록 ${bodyScreen.length}',
                  style: textStyle(20, Colors.black),
                  decoration: const InputDecoration.collapsed(
                    hintText: "",
                    border: InputBorder.none,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 4,
              child: TextButton(
                child: TextFormField(
                  initialValue: cnt ?? 'a ${bodyScreen.length * 2}',
                  style: textStyle(25, Colors.blue),
                  decoration: const InputDecoration.collapsed(
                    hintText: "",
                    border: InputBorder.none,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 2,
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        toggle_ = !toggle_;
                        toggle_
                            ? icon = const Icon(Icons.check)
                            : icon = const Icon(Icons.check_box_outline_blank);

                        Storage(game).writeData(dataDummy1);

                        bodyScreen.forEach((element) {
                          print("하;;");
                        });
                      });
                    },
                    icon: icon,
                    iconSize: 35,
                  );
                },
              ),
            ),
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

    bodyScreen = result;

    //퀘스트 목록 자동 등록 (파일 입출력)
    getQuests(game, type).then((quests) {
      quests.forEach((key, value) {
        result.insert(
            bodyScreen.length - 1, addContent(value[0], value[1], value[2]));
      });
      setState(() {});
    });
  }

  void loadLostArk() {
    bodyScreen = List<Widget>.empty(growable: true);
  }
}
