import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/theme_extensions.dart';
import '../../data/models/category_model.dart';
import '../../data/models/topic_model.dart';
import '../../data/datasources/quiz_local_datasource.dart';
import '../../data/repositories/quiz_repository_impl.dart';
import '../cubit/topics/topics_cubit.dart';
import '../cubit/topics/topics_state.dart';
import 'quiz_page.dart';

class TopicsPage extends StatelessWidget {
  final CategoryModel category;

  const TopicsPage({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopicsCubit(
        repository: QuizRepositoryImpl(
          localDataSource: QuizLocalDataSourceImpl(),
        ),
      )..loadTopics(category.path),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            category.arabicName,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
          ),
        ),
        body: BlocBuilder<TopicsCubit, TopicsState>(
          builder: (context, state) {
            if (state is TopicsLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: context.primaryColor,
                ),
              );
            }

            if (state is TopicsError) {
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

            if (state is TopicsLoaded) {
              return CustomScrollView(
                slivers: [
                  // Header with description
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.book_rounded,
                            size: 48,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state.categoryDetail.description,
                            style: GoogleFonts.cairo(
                              fontSize: 15,
                              color: Colors.white,
                              height: 1.8,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Section title
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            AppStrings.selectTopic,
                            style: GoogleFonts.cairo(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: context.textColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${state.categoryDetail.dataArray.length})',
                            style: GoogleFonts.cairo(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: context.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Topics grid
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final topic = state.categoryDetail.dataArray[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _TopicCard(
                              topic: topic,
                              index: index,
                            ),
                          );
                        },
                        childCount: state.categoryDetail.dataArray.length,
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final TopicModel topic;
  final int index;

  const _TopicCard({
    required this.topic,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Topic header
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: context.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: isDark
                        ? []
                        : [
                            BoxShadow(
                              color: context.primaryColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkBackground : Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.arabicName,
                        style: GoogleFonts.cairo(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: context.textColor,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.quiz_outlined,
                            size: 16,
                            color: context.secondaryTextColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '3 مستويات',
                            style: GoogleFonts.cairo(
                              fontSize: 13,
                              color: context.secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Level buttons
            Row(
              children: [
                Expanded(
                  child: _LevelButton(
                    level: 1,
                    label: AppStrings.level1,
                    icon: Icons.looks_one_rounded,
                    color: const Color(0xFF4CAF50),
                    onTap: () => _navigateToQuiz(context, topic, 1),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _LevelButton(
                    level: 2,
                    label: AppStrings.level2,
                    icon: Icons.looks_two_rounded,
                    color: const Color(0xFFFFA726),
                    onTap: () => _navigateToQuiz(context, topic, 2),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _LevelButton(
                    level: 3,
                    label: AppStrings.level3,
                    icon: Icons.looks_3_rounded,
                    color: const Color(0xFFEF5350),
                    onTap: () => _navigateToQuiz(context, topic, 3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToQuiz(BuildContext context, TopicModel topic, int level) {
    final levelFile = topic.files.firstWhere((file) => file.level == level);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(
          topicName: topic.arabicName,
          level: level,
          questionPath: levelFile.path,
        ),
      ),
    );
  }
}

class _LevelButton extends StatelessWidget {
  final int level;
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _LevelButton({
    required this.level,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 32,
                color: color,
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
