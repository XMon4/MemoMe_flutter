//quiz_page.dart
import 'package:flutter/material.dart';

class StartQuizPage extends StatelessWidget {
  const StartQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Quiz Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
