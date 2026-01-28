import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
  }) async {
    String res = "Some error occurred";
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(cred.user!.uid).set({
        'uid': cred.user!.uid,
        'email': email,
        'username': username,
        'bio': bio,
        'photoUrl': '',
        'followers': [],
        'following': [],
        'createdAt': DateTime.now(),
      });

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Log in
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
