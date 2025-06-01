import 'package:flutter/material.dart';
import 'package:quiz_app/questions.dart';
import 'package:quiz_app/quiz.dart';
import 'package:quiz_app/summary_data.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen({super.key, required this.choosenAnswers});
  final List<String> choosenAnswers;
  final List<Map<String, Object>> summary = [];

  List<Map<String, Object>> getSummary() {
    for (int i = 0; i < choosenAnswers.length; i++) {
      summary.add({
        "question_index": i,
        "question": questions[i].question,
        "correct_answer": questions[i].answers[0],
        "user_answer": choosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummary();
    final numOfTotalQuestions = summaryData.length;
    final numOfCorrectAnswer =
        summaryData.where((data) {
          return data["user_answer"] == data["correct_answer"];
        }).length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              "You answerd $numOfCorrectAnswer out of $numOfTotalQuestions answer correctly!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            SummaryData(summaryData: summaryData),
            SizedBox(height: 40),
            TextButton.icon(
              icon: Icon(Icons.restart_alt, color: Colors.white, size: 22),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Quiz()),
                );
              },
              label: const Text("Restart Quiz"),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
