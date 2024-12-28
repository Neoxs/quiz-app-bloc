import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

class AnswerSelected extends QuizEvent {
  final bool answer;

  const AnswerSelected(this.answer);

  @override
  List<Object?> get props => [answer];
}

class NextQuestionRequested extends QuizEvent {}

class QuizReset extends QuizEvent {}