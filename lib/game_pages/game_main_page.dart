import 'dart:async';

import 'package:flutter/material.dart';

class GameMainPage extends StatefulWidget {
  const GameMainPage({Key? key}) : super(key: key);

  @override
  State<GameMainPage> createState() => _GameMainPageState();
}

class _GameMainPageState extends State<GameMainPage> {

  Timer? _timer;
  int _start = 0;
  int cubeIndex = -1;
  int cubeCountD = 6;

  void startTimer() {
    const oneSec = Duration(milliseconds: 300);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == cubeCountD) {
          setState(() {
            timer.cancel();
            _start = 0;
          });
        } else {
          setState(() {
            int i = _start * 10 + cubeIndex;
            print(i);
            _start++;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double y = (h - w) / 2;
    double cubeSize = w / cubeCountD;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: y,
          ),
          Row(
            children: List.generate(cubeCountD, (x) => InkWell(
              onTap: (){
                cubeIndex = x + 1;
                startTimer();
              },
              child: Column(
                children: List.generate(cubeCountD, (y) => Cube(index: y * 10 + (x + 1), size: cubeSize)),
              ),
            )),

          ),
          SizedBox(
            height: y,
          ),
        ],
      ),
    );
  }
}

class Cube extends StatelessWidget {
  final double size;
  final int index;

  const Cube({Key? key , required this.index , required this.size }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Container(
        margin: const EdgeInsets.all(1),
        color:index.isEven ? Colors.grey[100]: Colors.grey[200],
        child: Center(child: Text(index.toString())),
      ),
    );
  }
}

