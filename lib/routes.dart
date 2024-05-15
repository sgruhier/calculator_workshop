import 'package:calculator/auth_service.dart';
import 'package:calculator/calculator.dart';
import 'package:calculator/login.dart';
import 'package:calculator/settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return const Calculator();
      },
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (BuildContext context, GoRouterState state) {
        return const Settings();
      },
      redirect: (context, state) async {
        var isAuthenticated = await authService.isAuthenticated;
        if (isAuthenticated == false) {
          return '/login';
        }
        return null;
      },
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
  ],
);
