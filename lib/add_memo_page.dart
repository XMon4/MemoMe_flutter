import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'memo.dart';
import 'memo_handler.dart';
import 'memo_card.dart';

class AddMemoPage extends StatefulWidget {
  const AddMemoPage({Key? key}) : super(key: key);

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

  void _addMemo() {
    String prompt = _promptController.text;
    String answer = _answerController.text;

    if (_formKey.currentState?.validate() ?? false) {
      final newMemo = Memo(
        prompt: prompt,
        answer: answer,
        promptImage: _promptImage?.path,
        answerImage: _answerImage?.path,
      );

      Provider.of<MemoHandler>(context, listen: false).addMemo(
        prompt,
        answer,
        promptImage: _promptImage?.path,
        answerImage: _answerImage?.path,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: MemoCard(memo: newMemo),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView( // Makes the layout scrollable
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                color: const Color(0xFF6A9FB5),
                padding: const EdgeInsets.fromLTRB(20.0, 16.0, 10.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'New memo',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFFFFC128),
                          fontFamily: 'Open Sans',
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    _promptImage == null
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Prompt:',
                          style: TextStyle(
                            fontSize: 40,
                            color: Color(0xFF333333),
                            fontFamily: 'Open Sans',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: TextFormField(
                                    controller: _promptController,
                                    validator: (value) {
                                      if (value == null || (value.isEmpty && _promptImage == null)) {
                                        return 'Please enter a prompt or select an image';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height * 0.03,
                                      color: Color(0xFF6A9FB5),
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter text here...',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF6A9FB5),
                                        fontSize: 24,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    maxLines: null,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.image, color: Color(0xFFFFC128), size: 56),
                              onPressed: () => _pickImage(true),
                            ),
                          ],
                        ),
                      ],
                    )
                        : Column(
                      children: [
                        const SizedBox(height: 10),
                        Image.file(
                          _promptImage!,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                        TextButton(
                          onPressed: () => setState(() => _promptImage = null),
                          child: const Text(
                            'Remove Image',
                            style: TextStyle(color: Color(0xFFFFC128)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _answerImage == null
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Answer:',
                          style: TextStyle(
                            fontSize: 40,
                            color: Color(0xFF333333),
                            fontFamily: 'Open Sans',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6A9FB5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: TextFormField(
                                    controller: _answerController,
                                    validator: (value) {
                                      if (value == null || (value.isEmpty && _answerImage == null)) {
                                        return 'Please enter an answer or select an image';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height * 0.03,
                                      color: const Color(0xFFF5F5F5),
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter text here...',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFF5F5F5),
                                        fontSize: 24,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    maxLines: null,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.image, color: Color(0xFFFFC128), size: 56),
                              onPressed: () => _pickImage(false),
                            ),
                          ],
                        ),
                      ],
                    )
                        : Column(
                      children: [
                        const SizedBox(height: 10),
                        Image.file(
                          _answerImage!,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                        TextButton(
                          onPressed: () => setState(() => _answerImage = null),
                          child: const Text(
                            'Remove Image',
                            style: TextStyle(color: Color(0xFFFFC128)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
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
                  onPressed: _addMemo,
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
