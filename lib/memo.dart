// memo.dart
class Memo {
  String id; // Firestore document ID (made non-final to allow updates)
  final String prompt;
  final String answer;
  final String? promptImage;
  final String? answerImage;

  Memo({
    required this.id,
    required this.prompt,
    required this.answer,
    this.promptImage,
    this.answerImage,
  });

  // Factory method to create a Memo object from Firestore document data
  factory Memo.fromFirestore(String id, Map<String, dynamic> data) {
    return Memo(
      id: id,
      prompt: data['prompt'] as String,
      answer: data['answer'] as String,
      promptImage: data['promptImage'] as String?,
      answerImage: data['answerImage'] as String?,
    );
  }

  // Convert a Memo object to a Firestore-friendly Map
  Map<String, dynamic> toFirestore() {
    return {
      'prompt': prompt,
      'answer': answer,
      'promptImage': promptImage,
      'answerImage': answerImage,
    };
  }
}
