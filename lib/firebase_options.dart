import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'AIzaSyDummyKeyForTesting123456789',
      appId: '1:123456789:web:abcdef0123456789abcdef',
      messagingSenderId: '123456789',
      projectId: 'instagram-flutter-clone-demo',
      authDomain: 'instagram-flutter-clone-demo.firebaseapp.com',
      storageBucket: 'instagram-flutter-clone-demo.appspot.com',
    );
  }
}
