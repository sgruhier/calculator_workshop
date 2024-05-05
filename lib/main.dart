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
        colorScheme: ThemeData.light().colorScheme.copyWith(
              primary: Colors.black,
              secondary: Colors.black.withOpacity(0.3),
            ),
        extensions: <ThemeExtension<dynamic>>[
          lightCustomKeyTheme,
        ],
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBgColor,
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Colors.white,
              secondary: Colors.white.withOpacity(0.3),
            ),
        extensions: <ThemeExtension<dynamic>>[
          darkCustomKeyTheme,
        ],
      ),
      themeMode: ThemeMode.light,
      home: const CalculatorLayout(),
    );
  }
}

class CalculatorLayout extends StatelessWidget {
  const CalculatorLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Calculator(),
          ),
        ),
      ),
    );
  }
}
