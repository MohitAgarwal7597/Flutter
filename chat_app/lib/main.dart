import 'package:chat_app/screens/authscreen.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData().copyWith(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 63, 17, 177))),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // body: ChatScreen(),
          body: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }
                if (snapshot.hasData) {
                  return const ChatScreen();
                } else {
                  return const AuthScreen();
                }
              }),
        ),
      );
}
