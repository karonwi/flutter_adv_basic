import 'package:adv_basics/answer_button.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;
  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;
  void answerQuestion(String selectedAnswer) {
    //this widget is used to access the declared in the above stateful class
    widget.onSelectAnswer(selectedAnswer);
    // currentQuestionIndex = currentQuestionIndex + 1;
    // currentQuestionIndex += 1;
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 154, 132, 233),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            //... the three dots used is called a spread
            ...currentQuestion.getShuffledAnswers().map((answer) {
              return AnswerButton(
                  text: answer,
                  onTap: () {
                    answerQuestion(answer);
                  });
            })
          ],
        ),
      ),
    );
  }
}
