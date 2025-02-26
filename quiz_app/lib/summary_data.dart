import 'package:flutter/material.dart';

class SummaryData extends StatelessWidget {
  const SummaryData({super.key, required this.summaryData});
  final List<Map<String, Object>> summaryData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children:
              summaryData.map((data) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      ((data["question_index"] as int) + 1).toString(),
                      style: TextStyle(
                        color: const Color.fromARGB(255, 253, 254, 255),
                        fontSize: 16,
                        backgroundColor: const Color.fromARGB(255, 120, 92, 8),
                      ),
                    ),

                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            data["question"] as String,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 251, 228, 246),
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "Your Answer: ",
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    133,
                                    117,
                                  ),
                                ),
                              ),
                              Text(
                                data["user_answer"] as String,
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    133,
                                    117,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Correct Answer: ",
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    123,
                                    243,
                                    115,
                                  ),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                data["correct_answer"] as String,
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    123,
                                    243,
                                    115,
                                  ),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
