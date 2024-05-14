import 'package:calculator/calculator.dart';
import 'package:calculator/routes.dart';
import 'package:calculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GoRoute route;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: lightBgColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: lightBgColor,
          elevation: 0,
        ),
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
        appBarTheme: const AppBarTheme(
          backgroundColor: darkBgColor,
          elevation: 0,
        ),
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Colors.white,
              secondary: Colors.white.withOpacity(0.3),
            ),
        extensions: <ThemeExtension<dynamic>>[
          darkCustomKeyTheme,
        ],
      ),
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}

class CalculatorLayout extends StatelessWidget {
  const CalculatorLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],
      ),
      body: const SafeArea(
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
