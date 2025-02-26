import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({required this.onSelectAnswer, super.key});
  final void Function(String answer) onSelectAnswer;
  @override
  State<StatefulWidget> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;
  var currIndex = 1;

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];
    void answerQuestion(String selectedAnswer) {
      widget.onSelectAnswer(selectedAnswer);
      setState(() {
        if (currentQuestionIndex < questions.length - 1) {
          currentQuestionIndex++;
          currIndex = currentQuestionIndex + 1;
        }
      });
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 43, 2, 78),
                const Color.fromARGB(255, 210, 49, 238),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: SizedBox(
              width: 450,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Q.$currIndex",
                        style: GoogleFonts.lato(
                          color: const Color.fromARGB(255, 200, 139, 253),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Expanded(
                        child: Text(
                          currentQuestion.question,
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 200, 139, 253),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  ...currentQuestion.getShuffledAnswers().map((answer) {
                    return AnswerButton(
                      answerText: answer,
                      onTap: () {
                        answerQuestion(answer);
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
