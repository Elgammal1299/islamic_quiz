import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/quiz_repository_impl.dart';
import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepository repository;

  QuizCubit({required this.repository}) : super(QuizInitial());

  Future<void> loadQuiz(String questionPath) async {
    emit(QuizLoading());
    try {
      final questions = await repository.getQuestions(questionPath);
      emit(QuizLoaded(questions: questions));
    } catch (e) {
      emit(QuizError(e.toString()));
    }
  }

  void selectAnswer(int answerIndex) {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      final updatedAnswers = Map<int, int>.from(currentState.userAnswers);
      updatedAnswers[currentState.currentQuestionIndex] = answerIndex;

      emit(currentState.copyWith(userAnswers: updatedAnswers));
    }
  }

  void nextQuestion() {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      if (currentState.currentQuestionIndex < currentState.questions.length - 1) {
        emit(currentState.copyWith(
          currentQuestionIndex: currentState.currentQuestionIndex + 1,
        ));
      }
    }
  }

  void previousQuestion() {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      if (currentState.currentQuestionIndex > 0) {
        emit(currentState.copyWith(
          currentQuestionIndex: currentState.currentQuestionIndex - 1,
        ));
      }
    }
  }

  void finishQuiz() {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      emit(currentState.copyWith(showResult: true));
    }
  }

  void resetQuiz() {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      emit(currentState.copyWith(
        currentQuestionIndex: 0,
        userAnswers: {},
        showResult: false,
      ));
    }
  }
}
