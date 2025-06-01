import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:po_smart_advisor/theme/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2, milliseconds: 500));
      final box = Hive.box('userBox');
      final storedUsername = box.get('username');

      if (!mounted) return;

      if (storedUsername != null && storedUsername.toString().isNotEmpty) {
        Navigator.popAndPushNamed(context, '/bottombar');
      } else {
        Navigator.popAndPushNamed(context, '/username');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: SweepGradient(
            // center: Alignment.center,
            transform: GradientRotation(1.137),
            startAngle: 0,
            endAngle: 3.14 * 2,
            stops: [0, 1],
            colors: [
              AppColor.containerDarkBlue,
              AppColor.containerLightBlue,
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_post_office,
                      size: 80, color: Colors.white),
                  const SizedBox(height: 24),
                  Text(
                    "PO Smart Advisor",
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColor.elevatedButtonWhite,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Your Trusted Guide to Post Office Savings",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColor.elevatedButtonGreyF,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const CircularProgressIndicator(
                    color: AppColor.elevatedButtonWhite,
                  ),
                  const Text(
                    'Loading Assets..',
                    style: TextStyle(
                        color: AppColor.elevatedButtonWhite, fontSize: 16),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
