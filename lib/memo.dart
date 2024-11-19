// memo.dart
class Memo {
  final String prompt;
  final String answer;
  final String? promptImage;
  final String? answerImage;

  Memo({
    required this.prompt,
    required this.answer,
    this.promptImage,
    this.answerImage,
  });
}
