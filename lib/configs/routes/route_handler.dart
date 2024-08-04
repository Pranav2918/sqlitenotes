import 'package:flutter/material.dart';
import 'package:sqlitedemo/configs/routes/app_routes.dart';
import 'package:sqlitedemo/presentation/add_notes/add_notes.dart';
import 'package:sqlitedemo/presentation/home/home_screen.dart';
import 'package:sqlitedemo/presentation/splash_screen.dart';

class AppRouteHandler {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case AppRoute.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case AppRoute.addNotes:
        return MaterialPageRoute(
          builder: (context) => const AddNotes(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Placeholder(),
          ),
        );
    }
  }
}
