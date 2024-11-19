import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memo_handler.dart';
import 'memome_home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MemoHandler(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MemoMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.transparent, // Make the app bar color transparent by default
          toolbarTextStyle: TextStyle(color: Colors.transparent), // Hide toolbar text
          titleTextStyle: TextStyle(color: Colors.transparent), // Hide title text
        ),
      ),
      home: const MemomeHome(), // The entry point of your app
    );
  }
}
