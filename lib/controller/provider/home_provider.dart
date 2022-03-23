import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numbers_addition/model/model_cube.dart';

class HomeProvider extends ChangeNotifier {
  List<int> numbersList = [2];
  List<Color> cubeColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.deepPurple,
    Colors.orange,
    Colors.pinkAccent,
    Colors.cyanAccent,
    Colors.indigo,
    Colors.blueAccent,
    Colors.deepOrangeAccent,
    Colors.cyanAccent,
    Colors.lightBlue
  ];
  List<ModelCube> cubes = [];

  static const int x = 5, y = 7;
  double defaultTop = 0;

  Timer? timer;
  int _start = 0;
  bool canStart = true;
  double cubeSize = 0;

  void startTimer(BuildContext context, {required int x}) {
    cubes.add(ModelCube(
        index: x,
        right: 0,
        left: cubeSize * x,
        top: defaultTop,
        number: numbersList.last,
      color: cubeColors[numbersList.indexOf(numbersList.last)]
    ));
    notifyListeners();
    const oneSec = Duration(milliseconds: 300);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == y) {
          timer.cancel();
          _start = 0;
          canStart = true;
          notifyListeners();
        } else {
          int cubeIndex = _start * 10 + x + 1;
          ModelCube modelCube = cubes.last;

          int cubeBottomIndex = cubeIndex + 10;
          int cubeExistsBottomIndex = cubes.indexWhere((element) => element.index == cubeBottomIndex,cubeBottomIndex);
          if(cubeExistsBottomIndex >= 0){
            if(cubes[cubeExistsBottomIndex].number == modelCube.number) {
              cubes.removeAt(cubeExistsBottomIndex);
              modelCube.number *= 2;
              if(!numbersList.contains(modelCube.number)){

                numbersList.add(modelCube.number);
              }
            }else {
              modelCube.index = cubeIndex;
              modelCube.top = defaultTop + (_start * cubeSize);
              timer.cancel();
              _start = 0;
              canStart = true;
              notifyListeners();
              return;
            }
          }
          modelCube.index = cubeIndex;
          modelCube.top = defaultTop + (_start * cubeSize);
          _start++;
          notifyListeners();
        }
      },
    );
  }
}
