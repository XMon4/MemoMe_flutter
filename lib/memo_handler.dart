// memo_handler.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'memo.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class MemoHandler extends ChangeNotifier {
  List<Memo> _memos = [];
  List<Memo> get memos => _memos;

  bool isLoading = true; // Loading indicator
  late StreamSubscription _memoSubscription;

  MemoHandler() {
    // Listen to real-time updates from Firestore
    _memoSubscription = FirebaseFirestore.instance
        .collection('memos')
        .snapshots()
        .listen((snapshot) {
      _memos = snapshot.docs.map((doc) {
        return Memo.fromFirestore(doc.id, doc.data());
      }).toList();
      isLoading = false;
      notifyListeners();
    }, onError: (error) {
      print('Error fetching memos: $error');
      isLoading = false;
      notifyListeners();
    });
  }

  // Dispose of the subscription when no longer needed
  @override
  void dispose() {
    _memoSubscription.cancel();
    super.dispose();
  }

  // Add memo to Firestore
  Future<void> addMemoToFirestore(Memo memo) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance.collection('memos').add(memo.toFirestore());

      // Update the memo's ID with the generated Firestore ID
      memo.id = docRef.id;

      // No need to add to _memos here; the stream listener will handle it
    } catch (e) {
      print('Error adding memo: $e');
      rethrow; // Re-throw the exception to handle it in the UI
    }
  }
}
