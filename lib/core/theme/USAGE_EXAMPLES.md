# أمثلة استخدام نظام الـ Theme

## 🎨 أمثلة عملية

### 1. استخدام الألوان في الـ Widgets

```dart
// ❌ طريقة قديمة (لا تستخدمها)
Container(
  color: AppColors.background,
  child: Text(
    'مرحباً',
    style: TextStyle(color: AppColors.textPrimary),
  ),
)

// ✅ طريقة صحيحة مع Extensions
Container(
  color: context.backgroundColor,
  child: Text(
    'مرحباً',
    style: TextStyle(color: context.textColor),
  ),
)

// ✅ طريقة صحيحة مع Theme.of(context)
Container(
  color: Theme.of(context).scaffoldBackgroundColor,
  child: Text(
    'مرحباً',
    style: TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
    ),
  ),
)
```

### 2. استخدام Card مع Theme

```dart
Card(
  // اللون يأتي تلقائياً من الـ theme
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text(
          'عنوان',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.textColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'وصف',
          style: TextStyle(
            fontSize: 14,
            color: context.secondaryTextColor,
          ),
        ),
      ],
    ),
  ),
)
```

### 3. استخدام Colors مختلفة حسب الـ Theme

```dart
Container(
  decoration: BoxDecoration(
    color: context.cardColor,
    borderRadius: BorderRadius.circular(12),
    // Shadow فقط في Light mode
    boxShadow: context.isDarkMode
        ? []
        : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
    // Border فقط في Dark mode
    border: context.isDarkMode
        ? Border.all(
            color: context.dividerColor,
            width: 1,
          )
        : null,
  ),
  child: YourWidget(),
)
```

### 4. استخدام Gradient حسب الـ Theme

```dart
import '../../core/theme/app_theme_helper.dart';

Container(
  decoration: BoxDecoration(
    gradient: AppThemeHelper.getPrimaryGradient(context),
    borderRadius: BorderRadius.circular(16),
  ),
  child: YourWidget(),
)
```

### 5. استخدام Icons مع الـ Theme

```dart
Icon(
  Icons.home,
  color: context.primaryColor,
)

// أو للـ icons على الـ surface
Icon(
  Icons.settings,
  color: context.textColor,
)
```

### 6. AppBar مخصص

```dart
AppBar(
  title: Text('العنوان'),
  backgroundColor: context.surfaceColor,
  foregroundColor: context.textColor,
  elevation: context.isDarkMode ? 0 : 2,
  actions: [
    ThemeToggleButton(),
  ],
)
```

### 7. TextField/TextFormField

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'الاسم',
    // الألوان تأتي تلقائياً من inputDecorationTheme
  ),
)
```

### 8. Progress Indicators

```dart
CircularProgressIndicator(
  // اللون يأتي تلقائياً من الـ theme
  color: context.primaryColor,
)

// أو
LinearProgressIndicator(
  backgroundColor: context.dividerColor,
  color: context.primaryColor,
)
```

### 9. Divider

```dart
Divider(
  // اللون يأتي تلقائياً من dividerTheme
)

// أو يدوي
Divider(
  color: context.dividerColor,
  thickness: 1,
)
```

### 10. زر مخصص حسب الـ Theme

```dart
ElevatedButton(
  onPressed: () {},
  // الألوان تأتي تلقائياً من elevatedButtonTheme
  child: Text('اضغط هنا'),
)

// أو OutlinedButton
OutlinedButton(
  onPressed: () {},
  // الألوان تأتي تلقائياً من outlinedButtonTheme
  child: Text('اضغط هنا'),
)
```

## 🔧 الـ Extensions المتاحة

```dart
context.theme           // ThemeData
context.colors          // ColorScheme
context.textTheme       // TextTheme

context.primaryColor    // Primary color
context.secondaryColor  // Secondary color
context.surfaceColor    // Surface color
context.backgroundColor // Background color
context.textColor       // Primary text color
context.secondaryTextColor // Secondary text color
context.cardColor       // Card background color
context.dividerColor    // Divider color

context.isDarkMode      // bool
context.isLightMode     // bool
```

## 💡 نصائح

1. **استخدم Extensions**: أسرع وأسهل في القراءة
2. **تجنب الألوان الثابتة**: دائماً استخدم الألوان من الـ theme
3. **اختبر الوضعين**: تأكد أن الـ UI واضح في كلا الوضعين
4. **Shadows vs Borders**: استخدم shadows في Light وborders في Dark
5. **استخدم Theme widgets**: Card, AppBar, TextField تدعم الـ theme تلقائياً

## 🎯 Best Practices

```dart
// ✅ جيد - يستخدم theme
Container(
  color: context.cardColor,
  child: Text(
    'النص',
    style: TextStyle(color: context.textColor),
  ),
)

// ❌ سيء - ألوان ثابتة
Container(
  color: Colors.white,
  child: Text(
    'النص',
    style: TextStyle(color: Colors.black),
  ),
)

// ✅ جيد - elevation مشروط
Card(
  elevation: context.isDarkMode ? 0 : 2,
)

// ❌ سيء - elevation ثابت في كل الأحوال
Card(
  elevation: 4,
)
```

## 🚀 مثال كامل لصفحة

```dart
class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مثال'),
        actions: [ThemeToggleButton()],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'عنوان',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: context.textColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'وصف طويل هنا...',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.secondaryTextColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('اضغط هنا'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```
