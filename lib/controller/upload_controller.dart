import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as fire_core;

class UploadHandler {
  final storage = FirebaseStorage.instance;

  Future<void> uploadImage(String filePath, String fileName) async {
    File file = File(filePath);
    final storageRef = FirebaseStorage.instance.ref('profile/').child(fileName);

    try {
      await storageRef.putFile(file);
    } on fire_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String> getURLImage(String imageName) async {
    String getUrl = await storage.ref('profile/$imageName').getDownloadURL();

    return getUrl;
  }
}
