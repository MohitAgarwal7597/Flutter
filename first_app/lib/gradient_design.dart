import 'package:first_app/dice_roller.dart';
import 'package:flutter/material.dart';

class GradientDesign extends StatelessWidget {
  const GradientDesign({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 84, 4, 182),
            Color.fromARGB(255, 106, 4, 170),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(child: DiceRoller()),
    );
  }
}
