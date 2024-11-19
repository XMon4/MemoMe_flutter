import 'package:flutter/material.dart';

class StartQuizPage extends StatelessWidget {
  const StartQuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Quiz'),
      ),
      body: const Center(
        child: Text('This is the Start Quiz Page'),
      ),
    );
  }
}
