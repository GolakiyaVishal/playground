import 'package:flutter/material.dart';
import 'package:playground/src/implisit_animation.dart';
import 'package:playground/src/views/home_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final colors = [Colors.blue, Colors.red];
  final colorNames = ['Blue', 'Red'];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}


/*
home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                index = index == 0 ? 1 : 0;
              });
            },
            child: ImplisitAnimation(
              color: colors[index],
              colorName: colorNames[index],
            ),
          ),
        ),
      ),
*/