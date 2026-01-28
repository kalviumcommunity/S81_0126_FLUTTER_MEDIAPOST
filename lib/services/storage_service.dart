import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload post image to Firebase Storage
  /// Returns download URL after upload completes
  Future<String> uploadPostImage({
    required File imageFile,
    required String uid,
  }) async {
    try {
      // Generate unique filename with timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filename = '${uid}_$timestamp';

      // Create reference to storage location
      final ref = _storage.ref().child('posts/$uid/$filename.jpg');

      // Upload file with metadata
      final uploadTask = ref.putFile(
        imageFile,
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'uploadedBy': uid,
            'uploadedAt': DateTime.now().toString(),
          },
        ),
      );

      // Wait for upload to complete
      final snapshot = await uploadTask;

      // Get download URL (works globally via CDN)
      final downloadUrl = await ref.getDownloadUrl();

      return downloadUrl;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  /// Upload user profile picture
  /// Returns download URL after upload completes
  Future<String> uploadProfileImage({
    required File imageFile,
    required String uid,
  }) async {
    try {
      // Profile pics stored separately
      final ref = _storage.ref().child('profiles/$uid/profile.jpg');

      await ref.putFile(imageFile);
      return await ref.getDownloadUrl();
    } catch (e) {
      throw Exception('Error uploading profile image: $e');
    }
  }

  /// Delete file from storage
  /// Called when user deletes post or profile
  Future<void> deleteFile(String downloadUrl) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(downloadUrl);
      await ref.delete();
    } catch (e) {
      throw Exception('Error deleting file: $e');
    }
  }

  /// Get metadata about uploaded file
  /// Useful for checking file size, upload date, etc.
  Future<FullMetadata?> getFileMetadata(String downloadUrl) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(downloadUrl);
      return await ref.getMetadata();
    } catch (e) {
      return null;
    }
  }

  /// Stream upload progress
  /// Useful for progress indicators in UI
  Stream<double> uploadPostImageWithProgress({
    required File imageFile,
    required String uid,
  }) {
    return Stream.fromFuture(_getUploadProgress(imageFile, uid));
  }

  Future<double> _getUploadProgress(File imageFile, String uid) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filename = '${uid}_$timestamp';
      final ref = _storage.ref().child('posts/$uid/$filename.jpg');

      final uploadTask = ref.putFile(imageFile);

      // Listen to progress updates
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        print('Upload progress: ${progress.toStringAsFixed(2)}%');
      });

      await uploadTask;
      return 100.0;
    } catch (e) {
      throw Exception('Error tracking upload progress: $e');
    }
  }
}
