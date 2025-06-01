import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:po_smart_advisor/provider/app_provider.dart';
import 'package:po_smart_advisor/theme/app_color.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.tabPage});
  final void Function(int index) tabPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Text(
                'PO Smart Advisor',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              SizedBox(height: 1.h),
              // Greeting
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Hello, ${context.watch<AppProvider>().username}",
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2.r),
                    child: SvgPicture.asset(
                      'assets/images/plant.svg',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                "Explore government-backed savings schemes",
                style:
                    GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[600]),
              ),
              SizedBox(height: 1.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      tabPage(1);
                    },
                    child: const Text(
                      'View All Schemes >>',
                      style: TextStyle(color: Color.fromRGBO(37, 99, 235, 1)),
                    )),
              ),
              // Scheme Cards
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.75,
                  children: const [
                    SchemeCard(
                        title: "TD - 1 Year",
                        rate: " 6.9%",
                        lockIn: "6 Months",
                        assetName: 'assets/images/rupee.svg',
                        min: '1,000'),
                    SchemeCard(
                        title: "RD",
                        rate: "6.7%",
                        lockIn: "6 Months",
                        assetName: 'assets/images/shield.svg',
                        min: '100'),
                    SchemeCard(
                        title: "MIS",
                        rate: "7.4%",
                        lockIn: "1 Years",
                        assetName: 'assets/images/grow.svg',
                        min: '500'),
                    SchemeCard(
                        title: "KVP",
                        rate: "7.5%",
                        lockIn: "2.5 Years",
                        assetName: 'assets/images/calender.svg',
                        min: '10,000'),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              // CTA Box
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: const LinearGradient(
                    colors: [
                      AppColor.containerLightBlue,
                      AppColor.containerDarkBlue
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Get personalized scheme recommendations",
                      style: GoogleFonts.inter(
                          color: Colors.white, fontSize: 14.sp),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Based on your investment goals and timeline",
                            style: GoogleFonts.inter(
                              color: AppColor.elevatedButtonGreyF,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.elevatedButtonWhite,
                            foregroundColor:
                                (const Color.fromRGBO(30, 64, 175, 1)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          onPressed: () {
                            tabPage(2);
                          },
                          child: const Text(
                            "Calculate",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SchemeCard extends StatelessWidget {
  final String title;
  final String rate;
  final String lockIn;
  final String assetName;
  final String min;

  const SchemeCard({
    super.key,
    required this.title,
    required this.rate,
    required this.lockIn,
    required this.assetName,
    required this.min,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(assetName),
          SizedBox(height: 12.h),
          Text(
            title,
            style:
                GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          Text(rate,
              style: GoogleFonts.inter(
                  fontSize: 18.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          Text("Lock-in: $lockIn",
              style:
                  GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[700])),
          Text("Min: ₹$min",
              style:
                  GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[700])),
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              SvgPicture.asset('assets/images/blue_tick.svg'),
              Text("  Govt. Backed",
                  style: GoogleFonts.inter(fontSize: 11.sp, color: Colors.blue))
            ],
          ),
        ],
      ),
    );
  }
}
