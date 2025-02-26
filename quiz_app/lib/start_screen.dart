import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.changeScreen, {super.key});
  final void Function() changeScreen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: const Color.fromARGB(186, 255, 255, 255),
          ),
          SizedBox(height: 60),
          Text(
            "Learn In Fun Way!",
            style: GoogleFonts.kalam(
              fontSize: 25,
              color: const Color.fromARGB(255, 218, 188, 246),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: changeScreen,
            label: Text("Start Quiz", style: TextStyle(fontSize: 20)),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            icon: Icon(
              Icons.arrow_right_alt,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
