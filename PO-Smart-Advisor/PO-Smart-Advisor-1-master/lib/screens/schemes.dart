// import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:po_smart_advisor/model/all_schemes.dart';
import 'package:po_smart_advisor/theme/app_color.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';

class SchemesScreen extends StatefulWidget {
  const SchemesScreen({super.key});

  @override
  State<SchemesScreen> createState() => _SchemesScreenState();
}

Future<Map<String, dynamic>> loadMisDetailsJson() async {
  final jsonString =
      await rootBundle.loadString('assets/schemes_details/mis_details.json');
  return json.decode(jsonString);
}

Future<Map<String, dynamic>> loadSbDetailsJson() async {
  final jsonString =
      await rootBundle.loadString('assets/schemes_details/sb_details.json');
  return json.decode(jsonString);
}

Future<Map<String, dynamic>> loadKvpDetailsJson() async {
  final jsonString =
      await rootBundle.loadString('assets/schemes_details/kvp_details.json');
  return json.decode(jsonString);
}

Future<Map<String, dynamic>> loadScssDetailsJson() async {
  final jsonString =
      await rootBundle.loadString('assets/schemes_details/scss_details.json');
  return json.decode(jsonString);
}

Future<Map<String, dynamic>> loadRdDetailsJson() async {
  final jsonString =
      await rootBundle.loadString('assets/schemes_details/rd_details.json');
  return json.decode(jsonString);
}

Future<Map<String, dynamic>> loadTdDetailsJson() async {
  final jsonString =
      await rootBundle.loadString('assets/schemes_details/td_details.json');
  return json.decode(jsonString);
}

class _SchemesScreenState extends State<SchemesScreen> {
  // final slider = CircularPercentIndicator(
  //   radius: 70,
  //   lineWidth: 12,
  //   percent: .72, // Assume max 10% interest
  //   center:
  //       Text("%", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
  //   backgroundColor: Colors.grey.shade200,
  //   linearGradient: LinearGradient(colors: [
  //     const Color.fromARGB(255, 1, 161, 60),
  //     const Color.fromARGB(255, 103, 255, 159),
  //   ]),
  // ).animate().fade().scale(duration: 500.ms);

  final TextEditingController _dateController = TextEditingController();
  List<bool> _expandedTiles = [];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dateController.text = '${now.day}/${now.month}/${now.year}';
    _expandedTiles = List.generate(AllSchemes.schemes.length, (_) => false);
  }

  AllSchemes selectedScheme = AllSchemes.schemes[0];
  var _showCalculations = false;

  double userAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    24.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scheme Calculator',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    24.verticalSpace,
                  ],
                ),
              ),

              /// GridView as Sliver
              SliverPadding(
                  padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 4.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final scheme = AllSchemes.schemes[index];
                        return Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.h),
                            child: _schemeTile(
                                lockin: scheme.lockin,
                                index: index,
                                description: scheme.description,
                                title: scheme.title,
                                subtitle: scheme.subtitle,
                                min: scheme.minAmount,
                                max: scheme.maxAmount,
                                interest: scheme.interest,
                                compounding: scheme
                                        .compunding!.name.characters.first
                                        .toUpperCase() +
                                    scheme.compunding!.name.characters.string
                                        .substring(1)));
                      },
                      childCount: AllSchemes.schemes.length,
                    ),
                  )),

              /// All Remaining Widgets in a SliverList
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),

                    16.verticalSpace,
                    _labelText('Select Scheme'),
                    SizedBox(
                      height: 55.h,
                      child: DropdownButtonFormField<AllSchemes>(
                        value: selectedScheme,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        items: AllSchemes.schemes
                            .map((scheme) => DropdownMenuItem(
                                  value: scheme,
                                  child: Text(scheme.title),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedScheme = value!;
                          });
                        },
                      ),
                    ),

                    16.verticalSpace,
                    _labelText('Amount'),
                    SizedBox(
                      height: 55.h,
                      child: TextField(
                        onChanged: (value) {
                          if (value.isEmpty || value.trim().isEmpty) {
                            return;
                          }
                          userAmount = double.tryParse(value) ?? 0;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText:
                              'Min ₹${selectedScheme.minAmount} | Max ₹${selectedScheme.maxAmount}',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    _labelText('Start Date'),
                    SizedBox(
                      height: 55.h,
                      child: TextField(
                        keyboardType: TextInputType.none,
                        controller: _dateController,
                        readOnly: true,
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            _dateController.text =
                                '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Select Date',
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            size: 20.sp,
                            color: AppColor.containerLightBlue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    Align(
                      alignment: Alignment.topCenter,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showCalculations = !_showCalculations;
                            });
                          },
                          child: Text(
                              _showCalculations ? 'Clear' : 'Calculations')),
                    ),
                    // Assuming you want to show lockin for the first scheme by default
                    if (_showCalculations) ...[
                      Padding(
                        padding: EdgeInsets.only(top: 4.h, bottom: 12.h),
                        child: Text(
                          '*Withdrawal allowed after ${selectedScheme.lockin} of deposit',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColor.lightRed,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColor.lightRed),
                        ),
                      ),
                      _labelText(''),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          children:
                              _buildSchemeTable(userAmount, selectedScheme),
                        ),
                      ),
                      16.verticalSpace,
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [
                              AppColor.elevatedButtonblue,
                              AppColor.containerDarkBlue,
                            ],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: LinearProgressIndicator(
                          value: 0.9,
                          minHeight: 6.h,
                          // backgroundColor: Colors.grey[300],
                        ),
                      ),
                      12.verticalSpace,
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'Your ₹5,000/month becomes ₹3.24L in 5 years @6.7% compounded quarterly',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                      ),
                      16.verticalSpace,
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _schemeTile({
    required int index,
    required String title,
    required String subtitle,
    required double min,
    required double max,
    required double interest,
    required String description,
    required String compounding,
    required int lockin,
  }) {
    final isExpanded = _expandedTiles[index];
    return InkWell(
      onTap: () {
        setState(() {
          _expandedTiles[index] = !_expandedTiles[index];
        });
      },
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color:
              isExpanded ? AppColor.elevatedOrange : AppColor.containerDarkBlue,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.r,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(title,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.elevatedButtonWhite)),
                ),
                ExpandIcon(
                  color: AppColor.elevatedButtonWhite,
                  isExpanded: isExpanded,
                  onPressed: (value) {
                    setState(() {
                      _expandedTiles[index] = !_expandedTiles[index];
                    });
                  },
                ),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        showDragHandle: true,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24.r)),
                        ),
                        elevation: .50,
                        barrierColor: AppColor.containerDarkBlue.withAlpha(150),
                        backgroundColor: AppColor.containerDarkBlue,
                        context: context,
                        builder: (context) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            child: FutureBuilder<Map<String, dynamic>>(
                              future: loadRdDetailsJson(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error loading details'));
                                } else if (snapshot.hasData) {
                                  return buildMisDetails(snapshot.data!);
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.info_outline,
                      color: AppColor.elevatedButtonWhite,
                    )),
              ],
            ),
            if (isExpanded)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(subtitle,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColor.elevatedButtonWhite,
                              fontWeight: FontWeight.w800,
                            )),
                        Card(
                          margin: EdgeInsets.only(top: 6.h),
                          shadowColor: AppColor.blackText,
                          color: AppColor.elevatedButtonWhite,
                          elevation: 1.h,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text('Min Amount: ₹$min',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: AppColor.elevatedOrange
                                                  .withAlpha(200),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const Spacer(),
                                    Icon(Icons.trending_down,
                                        color: AppColor.elevatedOrange
                                            .withAlpha(200)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Max Amount: ₹$max',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: AppColor.elevatedOrange
                                                .withAlpha(200),
                                            fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    Icon(Icons.trending_up,
                                        color: AppColor.elevatedOrange
                                            .withAlpha(200)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Lockin Period: $lockin months',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: AppColor.elevatedOrange
                                                .withAlpha(200),
                                            fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    Icon(
                                      Icons.lock_rounded,
                                      color: AppColor.elevatedOrange
                                          .withAlpha(200),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Compounding: $compounding',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: AppColor.elevatedOrange
                                                .withAlpha(200),
                                            fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    Icon(
                                      compounding == 'None'
                                          ? Icons.cancel
                                          : Icons.check_circle_sharp,
                                      color: AppColor.elevatedOrange
                                          .withAlpha(200),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 50.horizontalSpace,
                  Flexible(
                    flex: 2,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: 50.r,
                          lineWidth: 5,

                          percent: (interest / 10.0)
                              .clamp(0.0, 1.0), // Assume max 10% interest
                          center: Text("$interest%",
                              style: const TextStyle(
                                  color: AppColor.blackText,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          backgroundColor: AppColor.elevatedButtonWhite,
                          linearGradient: const LinearGradient(colors: [
                            AppColor.elevatedOrange,
                            AppColor.blackText,
                          ]),
                        ).animate().fade().scale(duration: 250.ms),
                        const Card(
                          color: AppColor.blackText,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Interest',
                              style: TextStyle(
                                  color: AppColor.elevatedButtonWhite),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _labelText(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
    );
  }

  Widget _tableRow(
      String period, String deposited, String interest, String total,
      {bool isHeader = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _cell(period, isHeader),
          _cell(deposited, isHeader),
          _cell(interest, isHeader),
          _cell(total, isHeader),
        ],
      ),
    );
  }

  Widget _cell(String text, bool bold) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13.sp),
      ),
    );
  }

  List<Widget> _buildSchemeTable(double depositAmount, AllSchemes scheme) {
    final List<Widget> rows = [];
    final double annualRate = scheme.interest;
    final startDateParts = _dateController.text.split('/');
    final DateTime startDate = DateTime(
      int.parse(startDateParts[2]), // year
      int.parse(startDateParts[1]), // month
      int.parse(startDateParts[0]), // day
    );

    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    // Header
    rows.add(_tableRow("Financial Year", "Deposited", "Interest", "Total",
        isHeader: true));

    if (scheme.title.toLowerCase().contains("mis")) {
      final Map<String, double> yearlyBreakdown = {};
      final int totalMonths = 60;
      final monthlyInterest = (depositAmount * annualRate / 100) / 12;
      double totalInterest = 0;
      double totalInvested = 0;

      DateTime current = startDate;

      for (int i = 0; i < totalMonths; i++) {
        current = DateTime(current.year, current.month + 1, current.day);

        // Financial year key
        int fyStart = current.month >= 4 ? current.year : current.year - 1;
        String fy = "$fyStart-${fyStart + 1}";

        yearlyBreakdown[fy] = (yearlyBreakdown[fy] ?? 0) + monthlyInterest;
      }

      yearlyBreakdown.forEach((fy, interest) {
        double invested = depositAmount; // principal remains same for MIS
        double total = invested + interest;
        totalInterest += interest;
        totalInvested = invested; // remains constant for MIS

        rows.add(
          _tableRow(
            fy,
            "₹${invested.toStringAsFixed(0)}",
            "₹${interest.toStringAsFixed(2)}",
            "₹${total.toStringAsFixed(2)}",
          ),
        );
      });

      // Total row
      rows.add(const Divider());
      rows.add(
        _tableRow(
          "Total",
          "₹${totalInvested.toStringAsFixed(0)}",
          "₹${totalInterest.toStringAsFixed(2)}",
          "₹${(totalInvested + totalInterest).toStringAsFixed(2)}",
          isHeader: true,
        ),
      );

      return rows;
    }

    // fallback: existing logic for other schemes
    // Keep your original loop-based table here for non-MIS schemes
    // ...

    return rows;
  }
}

Widget buildMisDetails(Map<String, dynamic> data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          data['title'],
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.elevatedButtonWhite.withAlpha(200)),
        ),
      ),
      ...List<Widget>.from(data['sections'].map<Widget>((section) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section['heading'],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.blackText.withAlpha(200)),
              ),
              ...List<Widget>.from(section['points'].map<Widget>((point) {
                return Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                  child: Text(
                    '• $point',
                    style: TextStyle(color: AppColor.elevatedButtonWhite),
                  ),
                );
              })),
            ],
          ),
        );
      })),
    ],
  );
}
