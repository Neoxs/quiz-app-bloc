import 'package:equatable/equatable.dart';

class QuizState extends Equatable {
  final int currentIndex;
  final int score;
  final bool? selectedAnswer;
  final bool showResult;

  const QuizState({
    this.currentIndex = 0,
    this.score = 0,
    this.selectedAnswer,
    this.showResult = false,
  });

  QuizState copyWith({
    int? currentIndex,
    int? score,
    bool? selectedAnswer,
    bool? showResult,
  }) {
    return QuizState(
      currentIndex: currentIndex ?? this.currentIndex,
      score: score ?? this.score,
      selectedAnswer: selectedAnswer,
      showResult: showResult ?? this.showResult,
    );
  }

  @override
  List<Object?> get props => [currentIndex, score, selectedAnswer, showResult];
}