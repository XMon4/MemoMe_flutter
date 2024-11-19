import 'dart:io';
import 'package:flutter/material.dart';
import 'memo.dart';
import 'add_memo_page.dart';
import 'memome_home.dart';

class MemoCard extends StatelessWidget {
  final Memo memo;

  const MemoCard({Key? key, required this.memo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A9FB5), // Matches the top half color
        elevation: 0, // Removes shadow
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.edit, color: Colors.white), // Only pen (edit) icon
            onPressed: () {
              // Go back to the previous page
              Navigator.pop(context);
            },
          ),
        ),
      ),

      body: SingleChildScrollView( // Wrap the entire body in SingleChildScrollView
        child: Column(
          children: [
            // Prompt Section (Top Half)
            Container(
              color: const Color(0xFF6A9FB5), // Primary blue color for top half
              padding: const EdgeInsets.all(20.0),
              width: double.infinity, // Full width
              height: MediaQuery.of(context).size.height * 0.4, // Occupies 40% of the screen height
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (memo.promptImage != null)
                      Image.file(
                        File(memo.promptImage!),
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.contain,
                      ),
                    if (memo.promptImage != null) const SizedBox(height: 10),
                    if (memo.prompt.isNotEmpty)
                      Text(
                        memo.prompt,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFC128),
                          fontFamily: 'Open Sans',
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Answer Section (Bottom Half)
            Container(
              color: const Color(0xFFF5F5F5), // Background color for bottom half
              padding: const EdgeInsets.all(20.0),
              width: double.infinity, // Full width
              height: MediaQuery.of(context).size.height * 0.4, // Occupies 40% of the screen height
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (memo.answerImage != null)
                      Image.file(
                        File(memo.answerImage!),
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.contain,
                      ),
                    if (memo.answerImage != null) const SizedBox(height: 10),
                    if (memo.answer.isNotEmpty)
                      Text(
                        memo.answer,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontFamily: 'Open Sans',
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Navigation Buttons at the Bottom
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A9FB5), // Primary color
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Navigate to Home
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const MemomeHome()),
                            (route) => false,
                      );
                    },
                    child: const Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC128), // Accent color
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Navigate to Add New Memo
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddMemoPage()),
                      );
                    },
                    child: const Text(
                      'Add New Memo',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF333333),
                        fontFamily: 'Open Sans',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
