import 'package:find_pg_rooms/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:find_pg_rooms/widgets/custom_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'C:/Users/mohit/OneDrive/Desktop/Flutter/find_your_pg/lib/assets/home.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ElevatedButton(),
          SizedBox(height: 40),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                "Find the Best PGs & Rooms Near Your College\n Click Next to continue",
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                ),
                speed: Duration(milliseconds: 100), // Adjust typing speed
              ),
            ],
            totalRepeatCount: 1, // Play only once
          ),
          Expanded(child: SizedBox(height: double.infinity)),
          CustomButton(
            text: "Next",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
