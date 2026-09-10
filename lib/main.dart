// Tareas Uniandes
// Autor: Bryan Puma
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/task_list_screen.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const TareasUniandesApp());
}

class TareasUniandesApp extends StatelessWidget {
  const TareasUniandesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tareas Uniandes',
      debugShowCheckedModeBanner: false,
      locale: const Locale('es'),
      supportedLocales: const [
        Locale('es'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.uniandesBlue),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.uniandesBlue,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.uniandesYellow,
          foregroundColor: AppColors.uniandesBlue,
        ),
      ),
      home: const TaskListScreen(),
    );
  }
}
