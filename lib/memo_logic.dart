//memo_logic.dart
//import 'package:flutter/material.dart';
import 'memo_handler.dart';
import 'package:provider/provider.dart';

Memo? addMemoLogic(
    BuildContext context,
    String prompt,
    String answer, {
      required GlobalKey<FormState> formKey,
      String? promptImagePath,
      String? answerImagePath,
    }) {
  if (formKey.currentState?.validate() ?? false) {
    final newMemo = Memo(
      prompt: prompt,
      answer: answer,
      promptImage: promptImagePath,
      answerImage: answerImagePath,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Memo added successfully!')),
    );

    // Add memo to the MemoHandler
    Provider.of<MemoHandler>(context, listen: false).addMemo(
      prompt,
      answer,
      promptImage: promptImagePath,
      answerImage: answerImagePath,
    );

    return newMemo;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill out all fields')),
    );
    return null;
  }
}
