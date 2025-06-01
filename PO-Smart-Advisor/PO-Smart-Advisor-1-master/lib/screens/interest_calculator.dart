import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:po_smart_advisor/theme/app_color.dart';
import 'dart:math';

class SmartAdvisorScreen extends StatefulWidget {
  const SmartAdvisorScreen({super.key});

  @override
  State<SmartAdvisorScreen> createState() => _SmartAdvisorScreenState();
}

class _SmartAdvisorScreenState extends State<SmartAdvisorScreen> {
  double depositAmount = 100000;
  List<SchemeResult> recommendedSchemes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildInvestmentInput()),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            if (recommendedSchemes.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _buildSchemeCard(recommendedSchemes[index]),
                  childCount: recommendedSchemes.length,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          const Icon(Icons.arrow_back_ios_new),
          SizedBox(width: 8.w),
          Text(
            'Smart Advisor',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Investment Amount", style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 8.h),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.currency_rupee),
              hintText: "Enter deposit amount (Min. ₹1,000)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onChanged: (value) {
              setState(() {
                depositAmount = double.tryParse(value) ?? 100000;
              });
            },
          ),
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: () {
              setState(() {
                recommendedSchemes =
                    SchemeCalculator().recommend(depositAmount);
              });
            },
            child: const Text('Calculate'),
          )
        ],
      ),
    );
  }

  Widget _buildSchemeCard(SchemeResult result) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.containerLightBlue.withAlpha(25),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerLightBlue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(result.schemeName,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          Text("Total Maturity: ₹${result.finalAmount.toStringAsFixed(2)}"),
          Text("Effective Period: ${result.totalMonths} months"),
        ],
      ),
    );
  }
}

class SchemeResult {
  final String schemeName;
  final double finalAmount;
  final int totalMonths;

  SchemeResult(
      {required this.schemeName,
      required this.finalAmount,
      required this.totalMonths});
}

class SchemeCalculator {
  final int maxPeriodMonths = 115;
  final List<Map<String, dynamic>> schemeConfigs = [
    {"name": "KVP", "rate": 7.5, "months": 115},
    {"name": "NSC", "rate": 7.7, "months": 60},
    {"name": "RD", "rate": 6.7, "months": 60},
    {"name": "TD 1 Yr", "rate": 6.9, "months": 12},
    {"name": "TD 2 Yr", "rate": 7.0, "months": 24},
    {"name": "TD 3 Yr", "rate": 7.1, "months": 36},
    {"name": "TD 5 Yr", "rate": 7.5, "months": 60},
    {"name": "SCSS", "rate": 8.2, "months": 60},
    {"name": "SSY", "rate": 8.0, "months": 240},
    {"name": "MSSC", "rate": 7.5, "months": 60},
    {"name": "PPF", "rate": 7.1, "months": 180},
    {"name": "MIS", "rate": 7.4, "months": 60},
    {"name": "SB", "rate": 4.0, "months": 12},
  ];

  List<SchemeResult> recommend(double amount) {
    List<SchemeResult> results = [];

    for (var config in schemeConfigs) {
      final name = config['name'];
      final rate = config['rate'];
      final months = config['months'];

      int cycles = maxPeriodMonths ~/ months;
      double maturity = amount;

      for (int i = 0; i < cycles; i++) {
        maturity *= pow((1 + rate / 100), 1);
      }

      results.add(SchemeResult(
        schemeName: name,
        finalAmount: maturity,
        totalMonths: months * cycles,
      ));
    }

    results.sort((a, b) => b.finalAmount.compareTo(a.finalAmount));
    return results;
  }
}
