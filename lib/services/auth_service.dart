import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Authentication Service
/// Handles user authentication operations including signup, login, password reset, and account management
/// 
/// Features:
/// - User registration with email and password
/// - User login and session management
/// - Password reset via email
/// - User profile updates
/// - Account deletion
/// - Real-time authentication state monitoring
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ========== Authentication State ==========

  /// Get current authenticated user
  User? get currentUser => _auth.currentUser;

  /// Get current user UID
  String? get currentUserUID => _auth.currentUser?.uid;

  /// Stream of authentication state changes
  /// Useful for listening to auth state changes in real-time
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Check if user is authenticated
  bool get isAuthenticated => _auth.currentUser != null;

  /// Get current user email
  String? get currentUserEmail => _auth.currentUser?.email;

  /// Get current user display name
  String? get currentUserDisplayName => _auth.currentUser?.displayName;

  /// Get current user photo URL
  String? get currentUserPhotoURL => _auth.currentUser?.photoURL;

  // ========== Authentication Methods ==========

  /// Sign up with email and password
  /// Creates a new user account and stores user data in Firestore
  ///
  /// Parameters:
  ///   - email: User email address
  ///   - password: User password (minimum 6 characters)
  ///   - username: Display name for the user
  ///   - bio: User biography/description
  ///   - photoUrl: Optional profile picture URL
  ///
  /// Returns:
  ///   - "success" on successful registration
  ///   - Error message string on failure
  ///
  /// Example:
  /// ```dart
  /// String result = await authService.signUpUser(
  ///   email: 'user@example.com',
  ///   password: 'password123',
  ///   username: 'john_doe',
  ///   bio: 'Hello, I am John',
  /// );
  /// if (result == 'success') {
  ///   // Navigate to home screen
  /// }
  /// ```
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    String photoUrl = '',
  }) async {
    String res = "Some error occurred";
    try {
      // Validate inputs
      if (email.isEmpty || password.isEmpty || username.isEmpty) {
        return "Email, password, and username are required";
      }

      if (password.length < 6) {
        return "Password should be at least 6 characters";
      }

      // Create user account
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user profile with display name and photo
      await cred.user?.updateDisplayName(username);
      if (photoUrl.isNotEmpty) {
        await cred.user?.updatePhotoURL(photoUrl);
      }

      // Store user data in Firestore
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'uid': cred.user!.uid,
        'email': email,
        'username': username,
        'bio': bio,
        'photoUrl': photoUrl,
        'followers': [],
        'following': [],
        'followerCount': 0,
        'followingCount': 0,
        'postsCount': 0,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'isVerified': false,
      });

      res = "success";
      print('✅ User ${email} signed up successfully');
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      if (e.code == 'weak-password') {
        res = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        res = 'An account already exists with that email';
      } else if (e.code == 'invalid-email') {
        res = 'The email address is not valid';
      } else {
        res = e.message ?? 'An error occurred during signup';
      }
      print('❌ FirebaseAuthException during signup: ${e.code} - ${e.message}');
    } catch (err) {
      res = err.toString();
      print('❌ Error during signup: $err');
    }
    return res;
  }

  /// Log in with email and password
  /// Authenticates existing user and manages session
  ///
  /// Parameters:
  ///   - email: User email address
  ///   - password: User password
  ///
  /// Returns:
  ///   - "success" on successful login
  ///   - Error message string on failure
  ///
  /// Example:
  /// ```dart
  /// String result = await authService.loginUser(
  ///   email: 'user@example.com',
  ///   password: 'password123',
  /// );
  /// if (result == 'success') {
  ///   // Navigate to home screen
  /// }
  /// ```
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      // Validate inputs
      if (email.isEmpty || password.isEmpty) {
        return "Email and password are required";
      }

      // Sign in user
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = "success";
      print('✅ User ${email} logged in successfully');
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      if (e.code == 'user-not-found') {
        res = 'No user found with that email';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password provided';
      } else if (e.code == 'invalid-email') {
        res = 'The email address is not valid';
      } else if (e.code == 'user-disabled') {
        res = 'This user account has been disabled';
      } else {
        res = e.message ?? 'An error occurred during login';
      }
      print('❌ FirebaseAuthException during login: ${e.code} - ${e.message}');
    } catch (err) {
      res = err.toString();
      print('❌ Error during login: $err');
    }
    return res;
  }

  /// Log out current user
  /// Clears authentication state and session
  ///
  /// Returns:
  ///   - "success" on successful logout
  ///   - Error message string on failure
  ///
  /// Example:
  /// ```dart
  /// String result = await authService.signOut();
  /// if (result == 'success') {
  ///   // Navigate to login screen
  /// }
  /// ```
  Future<String> signOut() async {
    try {
      await _auth.signOut();
      print('✅ User logged out successfully');
      return "success";
    } catch (err) {
      print('❌ Error during logout: $err');
      return err.toString();
    }
  }

  // ========== Account Management Methods ==========

  /// Reset password via email
  /// Sends password reset email to user
  ///
  /// Parameters:
  ///   - email: User email address
  ///
  /// Returns:
  ///   - "success" if email sent successfully
  ///   - Error message string on failure
  ///
  /// Example:
  /// ```dart
  /// String result = await authService.resetPassword('user@example.com');
  /// ```
  Future<String> resetPassword(String email) async {
    try {
      if (email.isEmpty) {
        return "Email is required";
      }

      await _auth.sendPasswordResetEmail(email: email);
      print('✅ Password reset email sent to $email');
      return "success";
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? 'Failed to send password reset email';
      if (e.code == 'user-not-found') {
        message = 'No user found with that email';
      }
      print('❌ FirebaseAuthException during password reset: ${e.code}');
      return message;
    } catch (e) {
      print('❌ Error during password reset: $e');
      return e.toString();
    }
  }

  /// Update user profile
  /// Updates user's display name and photo URL
  ///
  /// Parameters:
  ///   - displayName: New display name
  ///   - photoUrl: New profile photo URL
  ///
  /// Returns:
  ///   - "success" on successful update
  ///   - Error message string on failure
  Future<String> updateUserProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return "No authenticated user found";
      }

      if (displayName != null && displayName.isNotEmpty) {
        await user.updateDisplayName(displayName);
      }

      if (photoUrl != null && photoUrl.isNotEmpty) {
        await user.updatePhotoURL(photoUrl);
      }

      // Also update Firestore
      await _firestore.collection('users').doc(user.uid).update({
        if (displayName != null && displayName.isNotEmpty)
          'username': displayName,
        if (photoUrl != null && photoUrl.isNotEmpty) 'photoUrl': photoUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print('✅ User profile updated successfully');
      return "success";
    } catch (e) {
      print('❌ Error updating user profile: $e');
      return e.toString();
    }
  }

  /// Delete user account
  /// Permanently deletes user account and removes from Firestore
  ///
  /// Note: This is a permanent action and cannot be undone
  ///
  /// Returns:
  ///   - "success" on successful deletion
  ///   - Error message string on failure
  Future<String> deleteUserAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return "No authenticated user found";
      }

      // Delete user document from Firestore
      await _firestore.collection('users').doc(user.uid).delete();

      // Delete user account
      await user.delete();

      print('✅ User account deleted successfully');
      return "success";
    } catch (e) {
      print('❌ Error deleting user account: $e');
      return e.toString();
    }
  }

  /// Get user data from Firestore
  /// Retrieves user information stored in Firestore
  ///
  /// Parameters:
  ///   - uid: User ID
  ///
  /// Returns:
  ///   - Map containing user data or null if not found
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      print('❌ Error fetching user data: $e');
      return null;
    }
  }

  /// Stream of current user data from Firestore
  /// Useful for real-time updates of user profile
  ///
  /// Returns:
  ///   - Stream of user data Map
  Stream<DocumentSnapshot<Map<String, dynamic>>>? getUserDataStream(
      String uid) {
    try {
      return _firestore.collection('users').doc(uid).snapshots();
    } catch (e) {
      print('❌ Error getting user data stream: $e');
      return null;
    }
  }
}
