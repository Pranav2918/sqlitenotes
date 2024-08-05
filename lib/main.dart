import 'package:flutter/material.dart';
import 'package:sqlitedemo/configs/routes/app_routes.dart';
import 'package:sqlitedemo/configs/routes/route_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      initialRoute: AppRoute.splashScreen,
      onGenerateRoute: AppRouteHandler.onGenerateRoute,
    );
  }
}
