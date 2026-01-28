import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user by uid
  Future<DocumentSnapshot> getUserData(String uid) async {
    return await _firestore.collection('users').doc(uid).get();
  }

  // Get all posts
  Stream<QuerySnapshot> getAllPosts() {
    return _firestore
        .collection('posts')
        .orderBy('datePublished', descending: true)
        .snapshots();
  }

  // Get user posts
  Stream<QuerySnapshot> getUserPosts(String uid) {
    return _firestore
        .collection('posts')
        .where('uid', isEqualTo: uid)
        .orderBy('datePublished', descending: true)
        .snapshots();
  }

  // Like post
  Future<void> likePost(String postId, String uid) async {
    await _firestore.collection('posts').doc(postId).update({
      'likes': FieldValue.arrayUnion([uid]),
    });
  }

  // Unlike post
  Future<void> unlikePost(String postId, String uid) async {
    await _firestore.collection('posts').doc(postId).update({
      'likes': FieldValue.arrayRemove([uid]),
    });
  }

  // Add comment
  Future<void> addComment(
    String postId,
    String text,
    String uid,
    String name,
    String profilePic,
  ) async {
    await _firestore.collection('posts').doc(postId).collection('comments').add({
      'uid': uid,
      'name': name,
      'profilePic': profilePic,
      'text': text,
      'datePublished': DateTime.now(),
      'likes': [],
    });

    await _firestore.collection('posts').doc(postId).update({
      'commentCount': FieldValue.increment(1),
    });
  }

  // Get comments
  Stream<QuerySnapshot> getComments(String postId) {
    return _firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('datePublished', descending: true)
        .snapshots();
  }

  // Follow user
  Future<void> followUser(String myUid, String targetUid) async {
    await _firestore.collection('users').doc(myUid).update({
      'following': FieldValue.arrayUnion([targetUid]),
    });

    await _firestore.collection('users').doc(targetUid).update({
      'followers': FieldValue.arrayUnion([myUid]),
    });
  }

  // Unfollow user
  Future<void> unfollowUser(String myUid, String targetUid) async {
    await _firestore.collection('users').doc(myUid).update({
      'following': FieldValue.arrayRemove([targetUid]),
    });

    await _firestore.collection('users').doc(targetUid).update({
      'followers': FieldValue.arrayRemove([myUid]),
    });
  }

  // Search users
  Future<QuerySnapshot> searchUsers(String query) {
    return _firestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query)
        .where('username', isLessThan: query + 'z')
        .get();
  }
}
