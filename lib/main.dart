import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'data/datasources/quiz_local_datasource.dart';
import 'data/repositories/quiz_repository_impl.dart';
import 'presentation/cubit/categories/categories_cubit.dart';
import 'presentation/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit(
            repository: QuizRepositoryImpl(
              localDataSource: QuizLocalDataSourceImpl(),
            ),
          )..loadCategories(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: AppStrings.appTitle,
            debugShowCheckedModeBanner: false,
            locale: const Locale('ar'),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [const Locale('ar')],
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
           themeMode: themeMode,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
