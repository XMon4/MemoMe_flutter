// memo_card.dart
import 'package:flutter/material.dart';
import 'memo.dart';
import 'memome_home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'add_memo_page.dart';

class MemoCard extends StatelessWidget {
  final Memo memo;

  const MemoCard({super.key, required this.memo});

  @override
  Widget build(BuildContext context) {
    // Updated code to use Image.network or CachedNetworkImage
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A9FB5),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Wrap the entire body in SingleChildScrollView
        child: Column(
          children: [
            // Prompt Section (Top Half)
            Container(
              color: const Color(0xFF6A9FB5),
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (memo.promptImage != null)
                      CachedNetworkImage(
                        imageUrl: memo.promptImage!,
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
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
              color: const Color(0xFFF5F5F5),
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (memo.answerImage != null)
                      CachedNetworkImage(
                        imageUrl: memo.answerImage!,
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
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
                      backgroundColor: const Color(0xFF6A9FB5),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
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
                      backgroundColor: const Color(0xFFFFC128),
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
