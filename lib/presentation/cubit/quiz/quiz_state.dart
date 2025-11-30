import 'package:equatable/equatable.dart';
import '../../../data/models/question_model.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<QuestionModel> questions;
  final int currentQuestionIndex;
  final Map<int, int> userAnswers; // questionIndex -> answerIndex
  final bool showResult;

  const QuizLoaded({
    required this.questions,
    this.currentQuestionIndex = 0,
    this.userAnswers = const {},
    this.showResult = false,
  });

  QuizLoaded copyWith({
    List<QuestionModel>? questions,
    int? currentQuestionIndex,
    Map<int, int>? userAnswers,
    bool? showResult,
  }) {
    return QuizLoaded(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      userAnswers: userAnswers ?? this.userAnswers,
      showResult: showResult ?? this.showResult,
    );
  }

  int get correctAnswersCount {
    int count = 0;
    userAnswers.forEach((questionIndex, answerIndex) {
      if (questions[questionIndex].correctAnswerIndex == answerIndex) {
        count++;
      }
    });
    return count;
  }

  double get scorePercentage {
    if (questions.isEmpty) return 0;
    return (correctAnswersCount / questions.length) * 100;
  }

  @override
  List<Object?> get props => [questions, currentQuestionIndex, userAnswers, showResult];
}

class QuizError extends QuizState {
  final String message;

  const QuizError(this.message);

  @override
  List<Object?> get props => [message];
}
