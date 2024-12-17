// firebase_storage_service.dart
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload image to Firebase Storage and return the download URL
  Future<String?> uploadImageToStorage(File imageFile, String imageName) async {
    try {
      // Upload the image
      TaskSnapshot snapshot = await _storage.ref('memos/$imageName').putFile(imageFile);

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null; // Return null on error
    }
  }
}
