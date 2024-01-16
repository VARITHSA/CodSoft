import 'package:flutter/material.dart';
import 'package:quiz_app/src/pages/english_page.dart';
import 'package:quiz_app/src/pages/history_page.dart';
import 'package:quiz_app/src/pages/home_page.dart';
import 'package:quiz_app/src/pages/maths_page.dart';
import 'package:quiz_app/src/pages/science_page.dart';
import 'package:quiz_app/src/utils/routes.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        Routes.englishPageRoute: (context) => const EnglishPage(),
        Routes.historyPageRoute: (context) => const HistoryPage(),
        Routes.mathsPageRoute: (context) => const MathsPage(),
        Routes.sciencePageRoute: (context) => const SciencePage(),
      },
    );
  }
}
