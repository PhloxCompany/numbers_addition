import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numbers_addition/controller/provider/home_provider.dart';
import 'package:provider/provider.dart';

class GameMainPage extends StatefulWidget {
  const GameMainPage({Key? key}) : super(key: key);

  @override
  State<GameMainPage> createState() => _GameMainPageState();
}

class _GameMainPageState extends State<GameMainPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;

    HomeProvider homeProvider = Provider.of(context , listen: false);

    homeProvider.cubeSize = w / HomeProvider.x;
    homeProvider.defaultTop = (h - (w / HomeProvider.x * HomeProvider.y)) / 2;


    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: homeProvider.defaultTop,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(HomeProvider.x, (x) =>
                    InkWell(
                      onTap: () {
                        if (homeProvider.canStart == true) {
                          homeProvider.canStart = false;
                          homeProvider.startTimer(context, x: x);
                        }
                      },
                      child: Column(
                        children: List.generate(HomeProvider.y, (y) =>
                            Cube(index: y * 10 + (x + 1),)),
                      ),
                    )),

              ),
            ],
          ),
          Consumer<HomeProvider>(
            builder: (context , provider , child ) {
              return IgnorePointer(
                child: Stack(
                  children: List.generate(
                      provider.cubes.length, (index) =>
                      AnimatedPositioned(
                          top:provider.cubes[index].top,
                          left:provider.cubes[index].left,
                          child: SizedBox(
                            width: provider.cubeSize,
                            height: provider.cubeSize,
                            child: Container(
                              margin: const EdgeInsets.all(1),
                              color: provider.cubeColors[provider.numbersList.indexOf(provider.cubes[index].number)] ,
                              child: Center(child: Text(provider.cubes[index].number.toString())),
                            ),
                          ), duration: const Duration(milliseconds: 300))),
                ),
              );
            }
          )
        ],
      ),
    );
  }
}

class Cube extends StatelessWidget {

  final int index;


  const Cube({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of(context , listen: false);
    return SizedBox(
      width: homeProvider.cubeSize,
      height: homeProvider.cubeSize,
      child: Container(
        margin: const EdgeInsets.all(1),
        color: index.isEven ? Colors.grey[100] : Colors.grey[200],
        child: Center(child: Text(index.toString())),
      ),
    );
  }
}

