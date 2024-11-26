// memo_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memo_handler.dart';
import 'memo_card.dart';

class MemoListScreen extends StatefulWidget {
  const MemoListScreen({super.key});

  @override
  _MemoListScreenState createState() => _MemoListScreenState();
}

class _MemoListScreenState extends State<MemoListScreen> {
  @override
  void initState() {
    super.initState();
    // No need to fetch memos manually; MemoHandler listens to changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Memos'),
        backgroundColor: const Color(0xFF6A9FB5),
      ),
      body: Consumer<MemoHandler>(
        builder: (context, memoHandler, child) {
          if (memoHandler.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (memoHandler.memos.isEmpty) {
            return const Center(child: Text('No memos available.'));
          } else {
            return ListView.builder(
              itemCount: memoHandler.memos.length,
              itemBuilder: (context, index) {
                return MemoCard(memo: memoHandler.memos[index]);
              },
            );
          }
        },
      ),
    );
  }
}
