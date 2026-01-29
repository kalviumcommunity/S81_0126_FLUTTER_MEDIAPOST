import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore Service
/// Handles all Firestore database operations including CRUD operations for posts, follows, likes, etc.
/// 
/// Features:
/// - Post creation, reading, updating, and deletion (CRUD)
/// - User follow/unfollow operations
/// - Post like/unlike functionality
/// - Comment management
/// - Real-time data streaming
/// - User search functionality
///
/// Database Structure:
/// ```
/// /users/{uid}
///   - uid, email, username, bio, photoUrl
///   - followers[], following[], followerCount, followingCount, postsCount
///   - createdAt, updatedAt
///
/// /posts/{postId}
///   - uid, username, description, postUrl, profImage
///   - likes[], likeCount, commentCount
///   - createdAt, updatedAt
///   - /comments/{commentId}
///     - uid, username, profilePic, text, createdAt
/// ```
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ========== Post Operations ==========

  /// Create a new post
  /// Adds a post document to Firestore and updates user's post count
  ///
  /// Parameters:
  ///   - uid: User ID of post creator
  ///   - username: Username of post creator
  ///   - description: Post caption/description
  ///   - postUrl: URL of post image
  ///   - profImage: Profile image URL of poster
  ///
  /// Returns:
  ///   - Post ID on success, empty string on failure
  Future<String> uploadPost({
    required String uid,
    required String username,
    required String description,
    required String postUrl,
    required String profImage,
  }) async {
    try {
      String postId = _firestore.collection('posts').doc().id;

      await _firestore.collection('posts').doc(postId).set({
        'postId': postId,
        'uid': uid,
        'username': username,
        'description': description,
        'postUrl': postUrl,
        'profImage': profImage,
        'likes': [],
        'likeCount': 0,
        'commentCount': 0,
        'datePublished': DateTime.now(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Increment user's post count
      await _firestore.collection('users').doc(uid).update({
        'postsCount': FieldValue.increment(1),
      });

      print('✅ Post uploaded successfully: $postId');
      return postId;
    } catch (e) {
      print('❌ Error uploading post: $e');
      return "";
    }
  }

  /// Get all posts as a stream
  /// Returns a real-time stream of all posts ordered by creation date
  ///
  /// Returns:
  ///   - Stream of posts QuerySnapshot
  Stream<QuerySnapshot> getAllPosts() {
    return _firestore
        .collection('posts')
        .orderBy('datePublished', descending: true)
        .snapshots();
  }

  /// Get user posts
  /// Returns a stream of posts created by a specific user
  ///
  /// Parameters:
  ///   - uid: User ID to fetch posts for
  ///
  /// Returns:
  ///   - Stream of user's posts QuerySnapshot
  Stream<QuerySnapshot> getUserPosts(String uid) {
    return _firestore
        .collection('posts')
        .where('uid', isEqualTo: uid)
        .orderBy('datePublished', descending: true)
        .snapshots();
  }

  /// Get single post
  /// Retrieves a specific post by ID
  ///
  /// Parameters:
  ///   - postId: ID of post to fetch
  ///
  /// Returns:
  ///   - Post data as DocumentSnapshot
  Future<DocumentSnapshot> getPost(String postId) async {
    return await _firestore.collection('posts').doc(postId).get();
  }

  /// Delete post
  /// Permanently removes a post and updates user's post count
  ///
  /// Parameters:
  ///   - postId: ID of post to delete
  ///   - uid: User ID of post owner
  ///
  /// Returns:
  ///   - true on success, false on failure
  Future<bool> deletePost(String postId, String uid) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();

      // Decrement user's post count
      await _firestore.collection('users').doc(uid).update({
        'postsCount': FieldValue.increment(-1),
      });

      print('✅ Post deleted successfully: $postId');
      return true;
    } catch (e) {
      print('❌ Error deleting post: $e');
      return false;
    }
  }

  // ========== Like Operations ==========

  /// Like a post
  /// Adds user to post's likes list and updates like count
  ///
  /// Parameters:
  ///   - postId: ID of post to like
  ///   - uid: User ID of liker
  Future<void> likePost(String postId, String uid) async {
    try {
      await _firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([uid]),
        'likeCount': FieldValue.increment(1),
      });
      print('✅ Post liked: $postId');
    } catch (e) {
      print('❌ Error liking post: $e');
    }
  }

  /// Unlike a post
  /// Removes user from post's likes list and updates like count
  ///
  /// Parameters:
  ///   - postId: ID of post to unlike
  ///   - uid: User ID of liker
  Future<void> unlikePost(String postId, String uid) async {
    try {
      await _firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([uid]),
        'likeCount': FieldValue.increment(-1),
      });
      print('✅ Post unliked: $postId');
    } catch (e) {
      print('❌ Error unliking post: $e');
    }
  }

  // ========== Comment Operations ==========

  /// Add comment to post
  /// Creates a new comment document and updates post's comment count
  ///
  /// Parameters:
  ///   - postId: ID of post being commented on
  ///   - text: Comment text
  ///   - uid: User ID of commenter
  ///   - name: Name of commenter
  ///   - profilePic: Profile picture URL of commenter
  Future<void> addComment(
    String postId,
    String text,
    String uid,
    String name,
    String profilePic,
  ) async {
    try {
      await _firestore.collection('posts').doc(postId).collection('comments').add({
        'uid': uid,
        'name': name,
        'username': name,
        'profilePic': profilePic,
        'text': text,
        'datePublished': DateTime.now(),
        'likes': [],
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Increment comment count
      await _firestore.collection('posts').doc(postId).update({
        'commentCount': FieldValue.increment(1),
      });

      print('✅ Comment added to post: $postId');
    } catch (e) {
      print('❌ Error adding comment: $e');
    }
  }

  /// Get comments for a post
  /// Returns a stream of all comments on a post
  ///
  /// Parameters:
  ///   - postId: ID of post
  ///
  /// Returns:
  ///   - Stream of comments QuerySnapshot
  Stream<QuerySnapshot> getComments(String postId) {
    return _firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('datePublished', descending: true)
        .snapshots();
  }

  /// Delete comment
  /// Removes a comment and updates post's comment count
  ///
  /// Parameters:
  ///   - postId: ID of post
  ///   - commentId: ID of comment to delete
  ///
  /// Returns:
  ///   - true on success, false on failure
  Future<bool> deleteComment(String postId, String commentId) async {
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .delete();

      await _firestore.collection('posts').doc(postId).update({
        'commentCount': FieldValue.increment(-1),
      });

      print('✅ Comment deleted');
      return true;
    } catch (e) {
      print('❌ Error deleting comment: $e');
      return false;
    }
  }

  // ========== Follow Operations ==========

  /// Get user data
  /// Retrieves user profile information
  ///
  /// Parameters:
  ///   - uid: User ID
  ///
  /// Returns:
  ///   - User data as DocumentSnapshot
  Future<DocumentSnapshot> getUserData(String uid) async {
    return await _firestore.collection('users').doc(uid).get();
  }

  /// Follow user
  /// Adds user to follower list and updates counts
  ///
  /// Parameters:
  ///   - myUid: User ID of follower
  ///   - targetUid: User ID being followed
  Future<void> followUser(String myUid, String targetUid) async {
    try {
      // Add to current user's following list
      await _firestore.collection('users').doc(myUid).update({
        'following': FieldValue.arrayUnion([targetUid]),
        'followingCount': FieldValue.increment(1),
      });

      // Add to target user's followers list
      await _firestore.collection('users').doc(targetUid).update({
        'followers': FieldValue.arrayUnion([myUid]),
        'followerCount': FieldValue.increment(1),
      });

      print('✅ Successfully followed user: $targetUid');
    } catch (e) {
      print('❌ Error following user: $e');
    }
  }

  /// Unfollow user
  /// Removes user from follower list and updates counts
  ///
  /// Parameters:
  ///   - myUid: User ID of follower
  ///   - targetUid: User ID being unfollowed
  Future<void> unfollowUser(String myUid, String targetUid) async {
    try {
      // Remove from current user's following list
      await _firestore.collection('users').doc(myUid).update({
        'following': FieldValue.arrayRemove([targetUid]),
        'followingCount': FieldValue.increment(-1),
      });

      // Remove from target user's followers list
      await _firestore.collection('users').doc(targetUid).update({
        'followers': FieldValue.arrayRemove([myUid]),
        'followerCount': FieldValue.increment(-1),
      });

      print('✅ Successfully unfollowed user: $targetUid');
    } catch (e) {
      print('❌ Error unfollowing user: $e');
    }
  }

  // ========== Search Operations ==========

  /// Search users
  /// Searches for users by username with case-insensitive matching
  ///
  /// Parameters:
  ///   - query: Username to search for
  ///
  /// Returns:
  ///   - QuerySnapshot of matching users
  Future<QuerySnapshot> searchUsers(String query) {
    return _firestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query)
        .where('username', isLessThan: '${query}z')
        .get();
  }

  /// Search users as stream
  /// Real-time search for users by username
  ///
  /// Parameters:
  ///   - query: Username to search for
  ///
  /// Returns:
  ///   - Stream of matching users QuerySnapshot
  Stream<QuerySnapshot> searchUsersStream(String query) {
    return _firestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query)
        .where('username', isLessThan: '${query}z')
        .snapshots();
  }

  // ========== Statistics Operations ==========

  /// Get trending posts
  /// Returns posts ordered by like count
  ///
  /// Returns:
  ///   - Stream of trending posts QuerySnapshot
  Stream<QuerySnapshot> getTrendingPosts({int limit = 20}) {
    return _firestore
        .collection('posts')
        .orderBy('likeCount', descending: true)
        .limit(limit)
        .snapshots();
  }

  /// Get user statistics
  /// Retrieves user's post count, follower count, following count
  ///
  /// Parameters:
  ///   - uid: User ID
  ///
  /// Returns:
  ///   - Map containing statistics: postsCount, followerCount, followingCount
  Future<Map<String, dynamic>?> getUserStatistics(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) return null;

      return {
        'postsCount': doc['postsCount'] ?? 0,
        'followerCount': doc['followerCount'] ?? 0,
        'followingCount': doc['followingCount'] ?? 0,
      };
    } catch (e) {
      print('❌ Error fetching user statistics: $e');
      return null;
    }
  }
}
