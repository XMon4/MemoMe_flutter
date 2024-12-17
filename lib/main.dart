import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'memo_handler.dart';
import 'memome_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase and handle potential errors
  await Firebase.initializeApp().catchError((e) {
    debugPrint('Error initializing Firebase: $e');
    // Exit the app if Firebase fails to initialize
    throw Exception('Failed to initialize Firebase');
  });

  runApp(
    ChangeNotifierProvider(
      create: (context) => MemoHandler(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MemoMe',
      theme: ThemeData(
        primaryColor: const Color(0xFF6A9FB5),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFFFC128),
        ),
        fontFamily: 'Open Sans',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Color(0xFF6A9FB5),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Open Sans',
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 60, color: Color(0xFFFFC128)),
          bodyLarge: TextStyle(fontSize: 24, color: Color(0xFF333333)),
        ),
      ),
      home: const MemomeHome(),
    );
  }
}
