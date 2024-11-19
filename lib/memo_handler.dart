import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memo.dart'; // Import Memo class from memo.dart
import 'memo_card.dart'; // Import MemoCard

// MemoHandler class to manage a list of memos
class MemoHandler extends ChangeNotifier {
  final List<Memo> _memos = [];

  List<Memo> get memos => _memos;

  void addMemo(String prompt, String answer, {String? promptImage, String? answerImage}) {
    final newMemo = Memo(
      prompt: prompt,
      answer: answer,
      promptImage: promptImage,
      answerImage: answerImage,
    );
    _memos.add(newMemo);
    notifyListeners();
  }
}
