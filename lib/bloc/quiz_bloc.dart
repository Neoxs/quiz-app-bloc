import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/question.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(const QuizState()) {
    on<AnswerSelected>(_onAnswerSelected);
    on<NextQuestionRequested>(_onNextQuestionRequested);
    on<QuizReset>(_onQuizReset);
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<QuizState> emit) {
    final currentQuestion = quizQuestions[state.currentIndex];
    final isCorrect = event.answer == currentQuestion.isCorrect;
    
    emit(state.copyWith(
      selectedAnswer: event.answer,
      score: isCorrect ? state.score + 1 : state.score,
    ));
  }

  void _onNextQuestionRequested(NextQuestionRequested event, Emitter<QuizState> emit) {
    final isLastQuestion = state.currentIndex == quizQuestions.length - 1;
    
    if (isLastQuestion) {
      emit(state.copyWith(showResult: true));
    } else {
      emit(state.copyWith(
        currentIndex: state.currentIndex + 1,
        selectedAnswer: null,
      ));
    }
  }

  void _onQuizReset(QuizReset event, Emitter<QuizState> emit) {
    emit(const QuizState());
  }
}