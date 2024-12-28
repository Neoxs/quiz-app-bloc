import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_event.dart';
import '../bloc/quiz_state.dart';
import '../models/question.dart';
import '../widgets/question_card.dart';
import '../widgets/answer_buttons.dart';
import '../widgets/quiz_progress.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key, required this.title}) : super(key: key);
  final String title;

  void _showResults(BuildContext context, QuizState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Terminé!'),
          content: Text(
            'Votre score: ${state.score}/${quizQuestions.length}\n'
            'Pourcentage: ${(state.score / quizQuestions.length * 100).toStringAsFixed(1)}%',
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<QuizBloc>().add(QuizReset());
                Navigator.of(context).pop();
              },
              child: const Text('Recommencer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo[800],
      ),
      body: BlocConsumer<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state.showResult) {
            _showResults(context, state);
          }
        },
        builder: (context, state) {
          final currentQuestion = quizQuestions[state.currentIndex];
          
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuestionCard(
                  question: currentQuestion,
                ),
                const SizedBox(height: 20),
                AnswerButtons(
                  selectedAnswer: state.selectedAnswer,
                  correctAnswer: currentQuestion.isCorrect,
                  onAnswerSelected: (bool answer) {
                    context.read<QuizBloc>().add(AnswerSelected(answer));
                  },
                ),
                const SizedBox(height: 20),
                if (state.selectedAnswer != null)
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<QuizBloc>().add(NextQuestionRequested());
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: Text(
                      state.currentIndex < quizQuestions.length - 1
                        ? 'Question Suivante'
                        : 'Voir les Résultats'
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[100],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                QuizProgress(
                  currentIndex: state.currentIndex,
                  totalQuestions: quizQuestions.length,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}