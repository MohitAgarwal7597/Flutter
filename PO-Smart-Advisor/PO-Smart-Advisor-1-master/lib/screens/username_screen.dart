import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:po_smart_advisor/provider/app_provider.dart';
import 'package:po_smart_advisor/theme/app_color.dart';
import 'package:provider/provider.dart';

class UsernameScreen extends StatelessWidget {
  const UsernameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      body: Container(
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),

              /// Logo
              ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: SvgPicture.asset(
                  'assets/images/username_screen_logo.svg',
                ),
              ),
              SizedBox(height: 32.h),

              /// Welcome Text
              Text(
                'Welcome Back!',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),

              SizedBox(height: 40.h),

              /// Label
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter Username',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              /// Username Input
              Consumer<AppProvider>(
                builder: (context, provider, _) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller, // ✅ ADD THIS
                          onSubmitted: (value) {
                            if (value.trim().isNotEmpty && value.length > 2) {
                              provider.setUsername = value;
                            } else {
                            }
                          },
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                          decoration: InputDecoration(
                            hintText: 'Enter your username',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: const Color(0xFF4ADE80),
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              /// Continue Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: Consumer<AppProvider>(
                  builder: (context, provider, _) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.elevatedOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () {
                      final username = controller.text.trim();
                      if (username.isNotEmpty && username.length > 2) {
                        provider.setUsername = username; // ✅ set it here too
                        Navigator.popAndPushNamed(context, '/bottombar');
                      } else {
                        // Optional: show validation error
                        print("Username invalid or too short");
                      }
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              /// Bottom Text
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/bottombar');
                },
                child: Text(
                  'Skip',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
