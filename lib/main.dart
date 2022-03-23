import 'package:flutter/material.dart';
import 'package:numbers_addition/controller/provider/home_provider.dart';
import 'package:numbers_addition/game_pages/game_main_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const _Provider());
}

class _Provider extends StatelessWidget {
  const _Provider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => HomeProvider(),)
    ],
      child: const MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const GameMainPage(),
    );
  }
}

