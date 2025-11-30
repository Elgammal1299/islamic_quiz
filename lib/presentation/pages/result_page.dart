import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../data/models/question_model.dart';

class ResultPage extends StatelessWidget {
  final String topicName;
  final int level;
  final int totalQuestions;
  final int correctAnswers;
  final double scorePercentage;
  final List<QuestionModel> questions;
  final Map<int, int> userAnswers;

  const ResultPage({
    super.key,
    required this.topicName,
    required this.level,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.scorePercentage,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final incorrectAnswers = totalQuestions - correctAnswers;
    final bool isPassed = scorePercentage >= 60;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          AppStrings.results,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // const SizedBox(height: 20),

            // Result Icon and Message
            // Container(
            //   padding: const EdgeInsets.all(32),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(20),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withValues(alpha: 0.08),
            //         blurRadius: 20,
            //         offset: const Offset(0, 10),
            //       ),
            //     ],
            //   ),
            //   child: Column(
            //     children: [
            //       // Container(
            //       //   width: 120,
            //       //   height: 120,
            //       //   decoration: BoxDecoration(
            //       //     shape: BoxShape.circle,
            //       //     gradient: isPassed
            //       //         ? const LinearGradient(
            //       //             colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
            //       //           )
            //       //         : const LinearGradient(
            //       //             colors: [Color(0xFFEF5350), Color(0xFFE57373)],
            //       //           ),
            //       //   ),
            //       //   child: Icon(
            //       //     isPassed ? Icons.emoji_events : Icons.refresh,
            //       //     size: 64,
            //       //     color: Colors.white,
            //       //   ),
            //       // ),
            //       const SizedBox(height: 24),
            //       Text(
            //         isPassed ? 'أحسنت!' : 'حاول مرة أخرى',
            //         style: GoogleFonts.cairo(
            //           fontSize: 32,
            //           fontWeight: FontWeight.bold,
            //           color: isPassed ? AppColors.correct : AppColors.incorrect,
            //         ),
            //       ),
            //       const SizedBox(height: 12),
            //       Text(
            //         topicName,
            //         style: GoogleFonts.cairo(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //           color: AppColors.textPrimary,
            //         ),
            //         textAlign: TextAlign.center,
            //       ),
            //       const SizedBox(height: 8),
            //       Container(
            //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //         decoration: BoxDecoration(
            //           color: AppColors.accent.withValues(alpha: 0.2),
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: Text(
            //           'المستوى $level',
            //           style: GoogleFonts.cairo(
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //             color: AppColors.accent,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 24),

            // Score Card with Circular Progress
            // Container(
            //   padding: const EdgeInsets.all(24),
            //   decoration: BoxDecoration(
            //     gradient: AppColors.primaryGradient,
            //     borderRadius: BorderRadius.circular(20),
            //     boxShadow: [
            //       BoxShadow(
            //         color: AppColors.primary.withValues(alpha: 0.3),
            //         blurRadius: 20,
            //         offset: const Offset(0, 10),
            //       ),
            //     ],
            //   ),
            //   child: Column(
            //     children: [
            //       Text(
            //         AppStrings.score,
            //         style: GoogleFonts.cairo(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white,
            //         ),
            //       ),
            //       const SizedBox(height: 16),
            //       SizedBox(
            //         width: 140,
            //         height: 140,
            //         child: Stack(
            //           alignment: Alignment.center,
            //           children: [
            //             SizedBox(
            //               width: 140,
            //               height: 140,
            //               child: CircularProgressIndicator(
            //                 value: scorePercentage / 100,
            //                 strokeWidth: 12,
            //                 backgroundColor: Colors.white.withValues(alpha: 0.3),
            //                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            //               ),
            //             ),
            //             Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text(
            //                   '${scorePercentage.toStringAsFixed(0)}%',
            //                   style: GoogleFonts.cairo(
            //                     fontSize: 36,
            //                     fontWeight: FontWeight.bold,
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //                 Text(
            //                   '$correctAnswers ${AppStrings.of} $totalQuestions',
            //                   style: GoogleFonts.cairo(
            //                     fontSize: 14,
            //                     color: Colors.white70,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 24),

            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.check_circle,
                    label: AppStrings.correct,
                    value: correctAnswers.toString(),
                    percentage: '${((correctAnswers / totalQuestions) * 100).toStringAsFixed(0)}%',
                    color: AppColors.correct,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    icon: Icons.cancel,
                    label: AppStrings.incorrect,
                    value: incorrectAnswers.toString(),
                    percentage: '${((incorrectAnswers / totalQuestions) * 100).toStringAsFixed(0)}%',
                    color: AppColors.incorrect,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Question Review Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'مراجعة الأسئلة',
                        style: GoogleFonts.cairo(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _QuestionReviewCard(
                          question: questions[index],
                          questionNumber: index + 1,
                          userAnswerIndex: userAnswers[index],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Action Buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: const Icon(Icons.home, color: Colors.white),
                    label: Text(
                      AppStrings.backToHome,
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.replay, color: AppColors.primary),
                    label: Text(
                      AppStrings.tryAgain,
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.primary, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String percentage;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: color,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              percentage,
              style: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionReviewCard extends StatelessWidget {
  final QuestionModel question;
  final int questionNumber;
  final int? userAnswerIndex;

  const _QuestionReviewCard({
    required this.question,
    required this.questionNumber,
    required this.userAnswerIndex,
  });

  @override
  Widget build(BuildContext context) {
    // Find the correct answer index
    final correctAnswerIndex = question.answers.indexWhere((answer) => answer.isCorrect == 1);
    final isCorrect = userAnswerIndex == correctAnswerIndex;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.correct.withValues(alpha: 0.05)
            : AppColors.incorrect.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCorrect
              ? AppColors.correct.withValues(alpha: 0.3)
              : AppColors.incorrect.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Header
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isCorrect ? AppColors.correct : AppColors.incorrect,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$questionNumber',
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  question.question,
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.6,
                  ),
                ),
              ),
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? AppColors.correct : AppColors.incorrect,
                size: 28,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Answers
          ...List.generate(question.answers.length, (index) {
            final answer = question.answers[index];
            final isUserAnswer = userAnswerIndex == index;
            final isCorrectAnswer = index == correctAnswerIndex;

            Color? backgroundColor;
            Color? borderColor;
            Color? textColor;
            IconData? icon;

            if (isCorrectAnswer) {
              backgroundColor = AppColors.correct.withValues(alpha: 0.1);
              borderColor = AppColors.correct;
              textColor = AppColors.correct;
              icon = Icons.check_circle;
            } else if (isUserAnswer && !isCorrect) {
              backgroundColor = AppColors.incorrect.withValues(alpha: 0.1);
              borderColor = AppColors.incorrect;
              textColor = AppColors.incorrect;
              icon = Icons.cancel;
            } else {
              backgroundColor = Colors.grey.withValues(alpha: 0.05);
              borderColor = Colors.grey.withValues(alpha: 0.2);
              textColor = AppColors.textSecondary;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: borderColor,
                    width: isCorrectAnswer || isUserAnswer ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    if (isCorrectAnswer || (isUserAnswer && !isCorrect))
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(
                          icon,
                          color: textColor,
                          size: 20,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        answer.answer,
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          fontWeight: (isCorrectAnswer || isUserAnswer)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: (isCorrectAnswer || isUserAnswer)
                              ? textColor
                              : AppColors.textPrimary,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
