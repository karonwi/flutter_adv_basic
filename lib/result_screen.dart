import 'package:flutter/material.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/question_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key, required this.chosenAnswers, required this.onRestart});
  final List<String> chosenAnswers;
  final void Function() onRestart;

//maps is just like dictionary in c#
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'user_answers': chosenAnswers[i],
        'correct_answer': questions[i].answers[0]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    var summaryData = getSummaryData();
    var totalNumberOfQuestions = questions.length;
    var numberOfCorrectQuestions = summaryData
        .where((answer) => answer['user_answers'] == answer['correct_answer'])
        .length;

    return SizedBox(
        width: double.infinity,
        child: Container(
            margin: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You answered $numberOfCorrectQuestions out of $totalNumberOfQuestions questions correctly',
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 230, 200, 253),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                QuestionSummary(summaryData),
                const SizedBox(
                  height: 30,
                ),
                TextButton.icon(
                    onPressed: onRestart,
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Restart Quiz'))
              ],
            )));
  }
}
