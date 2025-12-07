import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/theme_extensions.dart';
import '../../data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: isDark
                ? LinearGradient(
                    colors: [
                      AppColors.primaryLight.withValues(alpha: 0.3),
                      AppColors.primary.withValues(alpha: 0.2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : AppColors.primaryGradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkCardBackground
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _buildIcon(),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: Text(
                  category.arabicName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              Flexible(
                flex: 2,
                child: Text(
                  category.description,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final iconPath = category.icons.replaceFirst('/database/', 'assets/json/');
    print('iconPath: $iconPath');
    return SvgPicture.asset(
      iconPath,
      width: 50,
      height: 50,
      fit: BoxFit.contain,

      // colorFilter: const ColorFilter.mode(
      //   AppColors.primary,
      //   BlendMode.srcIn,
      // ),
    );
  }
}
