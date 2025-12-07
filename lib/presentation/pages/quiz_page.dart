import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/theme_extensions.dart';
import '../../data/datasources/quiz_local_datasource.dart';
import '../../data/repositories/quiz_repository_impl.dart';
import '../cubit/quiz/quiz_cubit.dart';
import '../cubit/quiz/quiz_state.dart';
import 'result_page.dart';

class QuizPage extends StatelessWidget {
  final String topicName;
  final int level;
  final String questionPath;

  const QuizPage({
    super.key,
    required this.topicName,
    required this.level,
    required this.questionPath,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(
        repository: QuizRepositoryImpl(
          localDataSource: QuizLocalDataSourceImpl(),
        ),
      )..loadQuiz(questionPath),
      child: BlocConsumer<QuizCubit, QuizState>(
        listener: (context, state) {
          if (state is QuizLoaded && state.showResult) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(
                  topicName: topicName,
                  level: level,
                  totalQuestions: state.questions.length,
                  correctAnswers: state.correctAnswersCount,
                  scorePercentage: state.scorePercentage,
                  questions: state.questions,
                  userAnswers: state.userAnswers,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                topicName,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
              ),
            ),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, QuizState state) {
    if (state is QuizLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: context.primaryColor,
        ),
      );
    }

    if (state is QuizError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.incorrect,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.error,
              style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.textColor,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                state.message,
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  color: context.secondaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    if (state is QuizLoaded) {
      final question = state.questions[state.currentQuestionIndex];
      final selectedAnswer = state.userAnswers[state.currentQuestionIndex];

      return Column(
        children: [
          // Progress Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: context.cardColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppStrings.question} ${state.currentQuestionIndex + 1} ${AppStrings.of} ${state.questions.length}',
                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: context.textColor,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'المستوى $level',
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: (state.currentQuestionIndex + 1) / state.questions.length,
                  backgroundColor: context.dividerColor,
                  valueColor: AlwaysStoppedAnimation<Color>(context.primaryColor),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),

          // Question and Answers
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Question Card
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: context.isDarkMode
                            ? LinearGradient(
                                colors: [
                                  AppColors.primaryLight.withValues(alpha: 0.4),
                                  AppColors.primary.withValues(alpha: 0.3),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        question.question,
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: context.isDarkMode
                              ? AppColors.darkTextPrimary
                              : Colors.white,
                          height: 1.8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Answer Options
                  ...List.generate(
                    question.answers.length,
                    (index) {
                      final answer = question.answers[index];
                      final isSelected = selectedAnswer == index;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _AnswerOption(
                          answer: answer.answer,
                          isSelected: isSelected,
                          onTap: () {
                            context.read<QuizCubit>().selectAnswer(index);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.cardColor,
              border: context.isDarkMode
                  ? Border(
                      top: BorderSide(
                        color: context.dividerColor,
                        width: 1,
                      ),
                    )
                  : null,
              boxShadow: context.isDarkMode
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
            ),
            child: Row(
              children: [
                if (state.currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<QuizCubit>().previousQuestion();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: AppColors.primary, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        AppStrings.previous,
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                if (state.currentQuestionIndex > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: selectedAnswer != null
                        ? () {
                            if (state.currentQuestionIndex < state.questions.length - 1) {
                              context.read<QuizCubit>().nextQuestion();
                            } else {
                              context.read<QuizCubit>().finishQuiz();
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      disabledBackgroundColor: context.dividerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      state.currentQuestionIndex < state.questions.length - 1
                          ? AppStrings.next
                          : AppStrings.finish,
                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return const SizedBox();
  }
}

class _AnswerOption extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  const _AnswerOption({
    required this.answer,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final selectedColor = isDark ? AppColors.primaryLight : AppColors.primary;
    final unselectedColor = context.cardColor;
    final borderColor = isSelected ? selectedColor : context.dividerColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          boxShadow: isSelected && !isDark
              ? [
                  BoxShadow(
                    color: selectedColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? (isDark ? AppColors.darkBackground : Colors.white)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? (isDark ? AppColors.darkBackground : Colors.white)
                      : context.dividerColor,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: selectedColor,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                answer,
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? (isDark ? AppColors.darkBackground : Colors.white)
                      : context.textColor,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
