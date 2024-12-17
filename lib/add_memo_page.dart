// add_memo_page.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'memo.dart';
import 'memo_handler.dart';
import 'firebase_storage_service.dart';
import 'memo_card.dart';

class AddMemoPage extends StatefulWidget {
  const AddMemoPage({super.key});

  @override
  _AddMemoPageState createState() => _AddMemoPageState();
}

class _AddMemoPageState extends State<AddMemoPage> {
  final TextEditingController _promptController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _promptImage;
  File? _answerImage;

  final ImagePicker _picker = ImagePicker();
  bool _isSubmitting = false; // Loading indicator for submission

  Future<void> _pickImage(bool isPrompt) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isPrompt) {
          _promptImage = File(pickedFile.path);
          _promptController.clear();
        } else {
          _answerImage = File(pickedFile.path);
          _answerController.clear();
        }
      });
    }
  }

  Future<void> _addMemo() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });

      String prompt = _promptController.text;
      String answer = _answerController.text;
      String? promptImageUrl;
      String? answerImageUrl;

      // Upload images to Firebase Storage
      if (_promptImage != null) {
        promptImageUrl = await FirebaseStorageService().uploadImageToStorage(
          _promptImage!,
          'prompt_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
        if (promptImageUrl == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to upload prompt image.')),
          );
          setState(() {
            _isSubmitting = false;
          });
          return;
        }
      }
      if (_answerImage != null) {
        answerImageUrl = await FirebaseStorageService().uploadImageToStorage(
          _answerImage!,
          'answer_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
        if (answerImageUrl == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to upload answer image.')),
          );
          setState(() {
            _isSubmitting = false;
          });
          return;
        }
      }

      // Create a new memo with placeholders for Firestore ID
      final newMemo = Memo(
        id: '', // Placeholder, Firestore will provide the ID
        prompt: prompt,
        answer: answer,
        promptImage: promptImageUrl,
        answerImage: answerImageUrl,
      );

      try {
        // Add the memo to Firestore
        await Provider.of<MemoHandler>(context, listen: false).addMemoToFirestore(newMemo);

        // Navigate to the preview screen with the updated memo
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MemoCard(memo: newMemo),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding memo: $e')),
        );
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all required fields.')),
      );
    }
  }

  @override
  void dispose() {
    _promptController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  // Rest of the code remains the same...

  @override
  Widget build(BuildContext context) {
    // Updated UI code with form validation messages and loading indicator
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A9FB5),
        automaticallyImplyLeading: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.101,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 80),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _isSubmitting
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              // Makes the layout scrollable
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rest of the UI code remains the same...
                    // Ensure to use TextFormField validators to display validation messages
                    // Example:
                    TextFormField(
                      controller: _promptController,
                      validator: (value) {
                        if ((value == null || value.isEmpty) && _promptImage == null) {
                          return 'Please enter a prompt or select an image';
                        }
                        return null;
                      },
                      // Rest of the TextFormField properties...
                    ),
                    // Similarly for the answer field
                    // Update the 'Add' button to disable when submitting
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC128),
                          foregroundColor: const Color(0xFF333333),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: _isSubmitting ? null : _addMemo,
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
