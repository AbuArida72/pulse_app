import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'dart:io';

class FireBaseService {
  Future<String> uploadImage({
    required String imagePath,
  }) async {
    try {
      File file = File(imagePath);
      String fileName = basename(file.path);
      String destination = 'u_image/$fileName';

      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref(destination);

      await ref.putFile(file);

      // Get the download URL after the image is uploaded
      String downloadURL = await ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      return '';
    }
  }
}