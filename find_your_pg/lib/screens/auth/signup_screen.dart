import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create an Account",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 28),
            ),
            SizedBox(height: 10),
            Text(
              "Sign up to get started",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 30),

            // Name Field
            CustomTextField(
              hintText: "Enter your full name",
              icon: Icons.person,
            ),
            SizedBox(height: 20),

            // Email Field
            CustomTextField(hintText: "Enter your email", icon: Icons.email),
            SizedBox(height: 20),

            // Password Field
            CustomTextField(
              hintText: "Create a password",
              icon: Icons.lock,
              isPassword: true,
            ),
            SizedBox(height: 20),

            // Signup Button
            CustomButton(
              text: "Sign Up",
              onPressed: () {
                // Signup logic
              },
            ),
            SizedBox(height: 20),

            // Already have an account? Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to Login
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
