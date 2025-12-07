# نظام الـ Themes في التطبيق

## الملفات الأساسية

### 1. `app_theme.dart`
يحتوي على تعريف الـ Light Theme و Dark Theme للتطبيق.

```dart
// استخدام الـ Light Theme
AppTheme.lightTheme

// استخدام الـ Dark Theme
AppTheme.darkTheme
```

### 2. `theme_cubit.dart`
يدير حالة الـ theme في التطبيق ويحفظها في SharedPreferences.

```dart
// تبديل الـ theme
context.read<ThemeCubit>().toggleTheme();

// تعيين theme معين
context.read<ThemeCubit>().setTheme(ThemeMode.dark);

// الحصول على الحالة الحالية
context.read<ThemeCubit>().isDarkMode
```

### 3. `app_colors.dart`
تم تحديثه ليحتوي على ألوان منفصلة للـ Light و Dark themes:
- `AppColors.lightBackground`, `AppColors.darkBackground`
- `AppColors.lightTextPrimary`, `AppColors.darkTextPrimary`
- إلخ...

## كيفية الاستخدام

### 1. استخدام الألوان من الـ Theme
بدلاً من استخدام `AppColors` مباشرة، استخدم `Theme.of(context)`:

```dart
// ❌ طريقة قديمة
color: AppColors.textPrimary

// ✅ طريقة جديدة
color: Theme.of(context).colorScheme.onSurface
```

### 2. زر تبديل الـ Theme
تم إنشاء Widget جاهز للاستخدام:

```dart
import '../widgets/theme_toggle_button.dart';

AppBar(
  actions: [
    ThemeToggleButton(),
  ],
)
```

### 3. الاستماع لتغييرات الـ Theme
```dart
BlocBuilder<ThemeCubit, ThemeMode>(
  builder: (context, themeMode) {
    // الكود هنا يتم إعادة بناءه عند تغيير الـ theme
    return Widget();
  },
)
```

## خريطة الألوان

| الاستخدام | Light Theme | Dark Theme |
|-----------|-------------|------------|
| Primary | `#2E7D32` (أخضر) | `#2E7D32` (أخضر) |
| Background | `#F5F5F5` (رمادي فاتح) | `#121212` (أسود) |
| Card Background | `#FFFFFF` (أبيض) | `#2C2C2C` (رمادي داكن) |
| Text Primary | `#212121` (أسود تقريباً) | `#E0E0E0` (أبيض تقريباً) |
| Text Secondary | `#757575` (رمادي) | `#B0B0B0` (رمادي فاتح) |

## التخزين التلقائي
الـ theme يتم حفظه تلقائياً في `SharedPreferences` ويتم استرجاعه عند فتح التطبيق.
