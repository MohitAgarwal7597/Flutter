// import 'package:find_your_pg/screens/auth/login_screen.dart';
import 'package:find_pg_rooms/screens/onboarding_screens.dart';
import 'package:flutter/material.dart';
// import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find Your PG',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: OnboardingScreen(),
    );
  }
}
