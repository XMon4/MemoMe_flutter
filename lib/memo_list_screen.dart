import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memo_handler.dart'; // Import the memo handler
import 'memo_card.dart'; // Import the memo card screen

class MemoListScreen extends StatelessWidget {
  const MemoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Memos'),
      ),
      body: Consumer<MemoHandler>(
        builder: (context, memoHandler, child) {
          return ListView.builder(
            itemCount: memoHandler.memos.length,
            itemBuilder: (context, index) {
              return MemoCard(memo: memoHandler.memos[index]);
            },
          );
        },
      ),
    );
  }
}
