import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/src/models/providers/todo_model.dart';
import 'package:todo_application/src/models/utils/page_routes.dart';
import 'package:todo_application/src/pages/Onboarding/onboarding_page.dart';
import 'package:todo_application/src/pages/home_page.dart';

void main() async {
  //*initialize Hive
  await Hive.initFlutter();
  // *INITIALIZE ADAPTER
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todoBox');
  runApp(ChangeNotifierProvider(
    create: (context) => TodoNotifier(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
      routes: {
        Routes.homePageRoute: (context) => const HomePage(),
      },
    );
  }
}
