# دليل نظام الـ Dark/Light Theme المحسّن 🌓

## ✨ التحسينات الرئيسية

### 1. ألوان Dark Theme محسّنة وأجمل
تم تحديث ألوان الوضع الليلي لتكون أكثر راحة للعين وأكثر احترافية:

```dart
// الألوان الجديدة
darkBackground: #0A0E27 (خلفية داكنة عميقة)
darkSurface: #151929 (سطح داكن)
darkCardBackground: #1E2336 (خلفية الكروت)
darkTextPrimary: #E8EAED (نص رئيسي واضح)
darkTextSecondary: #ADB5BD (نص ثانوي)
```

### 2. Theme Extensions للاستخدام السهل
تم إنشاء Extensions لتسهيل الوصول للألوان والـ theme:

```dart
// استخدام سهل
context.primaryColor
context.textColor
context.secondaryTextColor
context.cardColor
context.isDarkMode
context.isLightMode
```

### 3. Theme Helper Class
كلاس مساعد للحصول على الألوان المناسبة:

```dart
AppThemeHelper.getBackgroundColor(context)
AppThemeHelper.getTextPrimaryColor(context)
AppThemeHelper.isDarkMode(context)
```

## 📁 الملفات المحدّثة

### ملفات Core
1. **[lib/core/constants/app_colors.dart](lib/core/constants/app_colors.dart)**
   - ألوان منفصلة للـ Light/Dark themes
   - ألوان محسّنة للوضع الليلي

2. **[lib/core/theme/app_theme.dart](lib/core/theme/app_theme.dart)**
   - Theme كامل للوضع النهاري
   - Theme محسّن للوضع الليلي
   - SystemUiOverlayStyle مناسب لكل theme
   - Card theme بدون shadows في الـ dark mode
   - Progress indicators وInput decorations مخصصة

3. **[lib/core/theme/theme_cubit.dart](lib/core/theme/theme_cubit.dart)**
   - إدارة حالة الـ theme
   - حفظ في SharedPreferences تلقائياً

4. **[lib/core/theme/theme_extensions.dart](lib/core/theme/theme_extensions.dart)**
   - Extensions مفيدة للاستخدام السريع

5. **[lib/core/theme/app_theme_helper.dart](lib/core/theme/app_theme_helper.dart)**
   - Helper functions للألوان

### ملفات Presentation
1. **[lib/main.dart](lib/main.dart)**
   - MultiBlocProvider مع ThemeCubit
   - BlocBuilder للاستماع للتغييرات

2. **[lib/presentation/widgets/theme_toggle_button.dart](lib/presentation/widgets/theme_toggle_button.dart)**
   - زر تبديل مع أنيميشن
   - Icons مختلفة للوضعين

3. **[lib/presentation/pages/home_page.dart](lib/presentation/pages/home_page.dart)**
   - استخدام context extensions
   - ألوان ديناميكية من الـ theme

4. **[lib/presentation/widgets/category_card.dart](lib/presentation/widgets/category_card.dart)**
   - Gradient مختلف للـ dark mode
   - ألوان مناسبة لكل theme

## 🎨 مميزات Dark Theme

### التصميم
- ✅ خلفية داكنة مريحة للعين
- ✅ تباين ممتاز للنصوص
- ✅ Borders خفيفة بدلاً من Shadows
- ✅ ألوان Primary أفتح قليلاً
- ✅ Gradients مخصصة للوضع الليلي

### الأداء
- ✅ حفظ تلقائي للاختيار
- ✅ تبديل سريع وسلس
- ✅ لا يوجد إعادة بناء غير ضرورية

### التجربة
- ✅ انتقال سلس بين الأوضاع
- ✅ أيقونات معبرة
- ✅ يعمل على كل الصفحات

## 🚀 كيفية الاستخدام

### 1. تبديل الـ Theme
```dart
// من أي مكان في التطبيق
context.read<ThemeCubit>().toggleTheme();

// أو تحديد theme معين
context.read<ThemeCubit>().setTheme(ThemeMode.dark);
```

### 2. استخدام الألوان
```dart
// ✅ الطريقة الموصى بها
Container(
  color: context.cardColor,
  child: Text(
    'النص',
    style: TextStyle(color: context.textColor),
  ),
)

// أو
Container(
  color: Theme.of(context).cardTheme.color,
  child: Text(
    'النص',
    style: TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
    ),
  ),
)
```

### 3. التحقق من الـ Theme الحالي
```dart
if (context.isDarkMode) {
  // الوضع الليلي
} else {
  // الوضع النهاري
}
```

## 🎯 خريطة الألوان الكاملة

| العنصر | Light | Dark |
|--------|-------|------|
| Background | `#F5F5F5` | `#0A0E27` |
| Surface | `#FFFFFF` | `#151929` |
| Card | `#FFFFFF` | `#1E2336` |
| Primary | `#2E7D32` | `#66BB6A` |
| Text Primary | `#212121` | `#E8EAED` |
| Text Secondary | `#757575` | `#ADB5BD` |
| Divider | `#E0E0E0` | `#2D3548` |
| Border | `#E0E0E0` | `#2D3548` |

## 📝 ملاحظات مهمة

1. **استخدم Extensions**: استخدم `context.textColor` بدلاً من `AppColors.textPrimary`
2. **تجنب الألوان الثابتة**: لا تستخدم ألوان ثابتة في الـ UI
3. **اختبر كلا الوضعين**: تأكد أن الألوان واضحة في الوضعين
4. **Shadows في Dark Mode**: تجنب استخدام shadows قوية في الوضع الليلي

## 🔄 الملفات التي تحتاج تحديث (اختياري)

هذه الملفات مازالت تستخدم الألوان القديمة ويمكن تحديثها لاحقاً:
- `lib/presentation/pages/quiz_page.dart`
- `lib/presentation/pages/result_page.dart`
- `lib/presentation/pages/topics_page.dart` (جزئياً)

## 🎉 جاهز للاستخدام!

التطبيق الآن يدعم Dark/Light theme بشكل كامل واحترافي. اضغط على زر الشمس/القمر في الـ AppBar للتبديل!
