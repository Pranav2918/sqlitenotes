import 'package:flutter/material.dart';
import 'package:sqlitedemo/configs/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      debugPrint("Navigated");
      Navigator.pushNamed(context, AppRoute.homeScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 150.0,
        ),
      ),
    );
  }
}
