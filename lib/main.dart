import 'package:calculator/calculator.dart';
import 'package:calculator/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: lightBgColor,
        extensions: <ThemeExtension<dynamic>>[
          lightCustomKeyTheme,
        ],
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBgColor,
        extensions: <ThemeExtension<dynamic>>[
          darkCustomKeyTheme,
        ],
      ),
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Calculator(),
            ),
          ),
        ),
      ),
    );
  }
}
