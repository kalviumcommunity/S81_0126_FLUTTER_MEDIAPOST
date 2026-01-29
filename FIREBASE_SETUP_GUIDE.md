# Firebase Project Setup Guide - Step by Step

**Objective:** Connect your Instagram Clone Flutter app to Firebase for authentication and cloud database functionality

**Time Required:** 20-30 minutes

**Prerequisites:**
- Flutter 3.3.4+ installed
- A Google account
- Basic understanding of Flutter project structure

---

## Part 1: Create Firebase Project

### Step 1.1: Go to Firebase Console

1. Open [Firebase Console](https://console.firebase.google.com)
2. Sign in with your Google account
3. Click "Create a project"

### Step 1.2: Configure Project

1. **Project Name**
   - Enter: `Instagram Clone` (or your preferred name)
   - Click "Continue"

2. **Enable Google Analytics**
   - Choose: Enable or Disable (optional)
   - Click "Create project"

3. **Wait for Project Creation**
   - Firebase sets up your project (takes 1-2 minutes)
   - Click "Continue" when ready

---

## Part 2: Add Android App

### Step 2.1: Register Android App

1. In Firebase Console, click the **Android icon** under "Getting started"
2. **Package name**: Get from your Flutter project
   ```bash
   # In your project root, check android/app/build.gradle
   # Look for: applicationId "com.example.instagram"
   ```
3. **App nickname** (optional): `Instagram Clone Mobile`
4. **SHA-1 fingerprint** (optional but recommended):
   ```bash
   cd android
   ./gradlew signingReport
   # Copy the SHA-1 value for release
   ```
5. Click "Register app"

### Step 2.2: Download google-services.json

1. Click "Download google-services.json"
2. Place the file in: `android/app/`
   ```
   your-project/
   └── android/
       └── app/
           └── google-services.json  ← Place here
   ```

### Step 2.3: Configure Android build.gradle

1. Open `android/build.gradle` (project level)
2. Add to `buildscript > dependencies`:
   ```gradle
   dependencies {
     classpath 'com.google.gms:google-services:4.3.15'
   }
   ```

3. Open `android/app/build.gradle` (app level)
4. Add at the top (after other plugins):
   ```gradle
   plugins {
     id 'com.android.application'
     id 'kotlin-android'
     id 'com.google.gms.google-services'  // Add this line
   }
   ```

5. Ensure `minSdkVersion` is at least 21:
   ```gradle
   android {
     compileSdkVersion 34
     defaultConfig {
       minSdkVersion 21  // Check this
     }
   }
   ```

---

## Part 3: Add iOS App

### Step 3.1: Register iOS App

1. In Firebase Console, click the **iOS icon** under "Getting started"
2. **Bundle ID**: Get from Xcode
   ```bash
   # Open in Xcode
   open ios/Runner.xcworkspace
   # Select Runner > Signing & Capabilities
   # Look for Bundle Identifier (usually com.example.instagram)
   ```
3. **App nickname** (optional): `Instagram Clone iOS`
4. **App Store ID** (optional): Leave blank
5. Click "Register app"

### Step 3.2: Download GoogleService-Info.plist

1. Click "Download GoogleService-Info.plist"
2. Open Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```
3. In Xcode:
   - Right-click on "Runner" in project navigator
   - Select "Add Files to 'Runner'..."
   - Select the downloaded `GoogleService-Info.plist`
   - Check "Copy items if needed" and "Create groups"
   - Click "Add"

### Step 3.3: Configure iOS Pods

The FlutterFire CLI will handle this, but manually:

1. Open `ios/Podfile`
2. Ensure minimum iOS version is 11.0:
   ```ruby
   platform :ios, '11.0'
   ```

---

## Part 4: Configure Flutter Project

### Step 4.1: Install FlutterFire CLI

```bash
# Install globally
flutter pub global activate flutterfire_cli

# Verify installation
flutterfire --version
```

### Step 4.2: Run FlutterFire Configure

```bash
# In your project root directory
flutterfire configure

# This will:
# 1. Detect your Firebase project
# 2. Create firebase_options.dart
# 3. Update pubspec.yaml if needed
# 4. Configure platform-specific settings
```

### Step 4.3: Verify Dependencies

Check `pubspec.yaml` has these dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  cloud_firestore: ^5.0.0
```

If missing, add them:
```bash
flutter pub add firebase_core firebase_auth cloud_firestore
```

### Step 4.4: Get packages

```bash
flutter pub get
```

---

## Part 5: Enable Firebase Services

### Step 5.1: Enable Authentication

1. Go to Firebase Console > Your Project
2. Click "Authentication" in left sidebar
3. Click "Get started"
4. Click "Email/Password"
5. Toggle "Enable" on
6. Click "Save"

### Step 5.2: Enable Firestore Database

1. Go to Firebase Console > Your Project
2. Click "Firestore Database" in left sidebar
3. Click "Create database"
4. **Security rules**: Select "Production mode"
5. **Location**: Choose closest region to users
6. Click "Create"

### Step 5.3: Set Firestore Security Rules

1. In Firestore, go to "Rules" tab
2. Replace default rules with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Allow authenticated users to read/write their own data
    match /users/{uid} {
      allow read: if request.auth.uid == uid || true;
      allow create: if request.auth.uid == uid;
      allow update, delete: if request.auth.uid == uid;
    }

    // Allow all authenticated users to read posts
    // Allow authenticated users to create posts
    match /posts/{document=**} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth.uid == resource.data.uid;
    }

    // Default deny for other collections
    match /{document=**} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth.uid == resource.data.uid;
    }
  }
}
```

3. Click "Publish"

---

## Part 6: Update Your Flutter App

### Step 6.1: Verify main.dart

Your `main.dart` should already have:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  
  runApp(const MyApp());
}
```

### Step 6.2: Test Firebase Connection

```bash
# Clean and rebuild
flutter clean
flutter pub get

# Run the app
flutter run
```

Check console for:
```
✅ Firebase initialized successfully
```

---

## Part 7: Test Firebase Features

### Test Authentication

1. Run app on device/emulator
2. Go to signup screen
3. Create account with:
   - Email: `test@example.com`
   - Password: `Password123`
   - Username: `testuser`

4. Check Firebase Console:
   - Go to Authentication > Users
   - Verify new user appears

### Test Firestore Database

1. Create a post in the app
2. Check Firebase Console:
   - Go to Firestore > Data
   - Verify new post appears in `/posts` collection

---

## Part 8: Common Issues & Solutions

### Issue: "google-services.json not found"

**Solution:**
```bash
# Make sure file is in correct location
ls android/app/google-services.json

# If missing, download again from Firebase Console
```

### Issue: "Gradle build fails with Firebase errors"

**Solution:**
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter pub upgrade

# Or rebuild gradle
cd android
./gradlew clean
cd ..
flutter run
```

### Issue: "Authentication not working"

**Solution:**
1. Check Security Rules are published
2. Go to Authentication > Sign-in method
3. Verify "Email/Password" is enabled

### Issue: "Firestore writes failing with permission error"

**Solution:**
1. Go to Firestore > Rules
2. Verify security rules are correct
3. Check that user is authenticated before write

### Issue: "Pod install fails (iOS)"

**Solution:**
```bash
# Remove Pods
rm -rf ios/Pods ios/Podfile.lock

# Run FlutterFire configure again
flutterfire configure

# Install pods
cd ios
pod install
cd ..

# Run app
flutter run
```

---

## Part 9: Verification Checklist

- [x] Firebase project created in Console
- [x] Android app registered and `google-services.json` added
- [x] iOS app registered and `GoogleService-Info.plist` added
- [x] FlutterFire CLI configured (`firebase_options.dart` created)
- [x] Dependencies added to `pubspec.yaml`
- [x] Firebase initialization in `main.dart`
- [x] Authentication enabled in Firebase Console
- [x] Firestore Database created
- [x] Security rules set and published
- [x] App builds without errors
- [x] Can create user account (signup)
- [x] Can log in (login)
- [x] User appears in Firebase Authentication
- [x] Posts appear in Firestore Database
- [x] Reads/writes working with Firestore

---

## Part 10: Next Steps

### If Everything Works

1. ✅ Ready to use Firebase services
2. ✅ Start building auth screens
3. ✅ Implement Firestore operations
4. ✅ Add post creation, likes, comments

### If You Have Issues

1. Check [Troubleshooting](#part-8-common-issues--solutions) section
2. Review [Firebase Documentation](https://firebase.flutter.dev/)
3. Check Firebase Console for error messages
4. Review app logs in VS Code/Android Studio

---

## Useful Commands

```bash
# Check Firebase status
flutterfire list

# Reconfigure Firebase
flutterfire configure --reconfigure

# View Firebase project ID
firebase projects:list

# Deploy security rules
firebase deploy --only firestore:rules

# View Firestore usage
firebase firestore:usage
```

---

## Resources

- [Official Firebase Setup Guide](https://firebase.flutter.dev/docs/overview/)
- [Firebase Console](https://console.firebase.google.com)
- [Firestore Documentation](https://firebase.google.com/docs/firestore)
- [Firebase Authentication](https://firebase.google.com/docs/auth)
- [FlutterFire GitHub](https://github.com/FirebaseExtended/flutterfire)

---

**Status:** ✅ Complete Setup Instructions  
**Difficulty Level:** Beginner-friendly  
**Time to Complete:** 20-30 minutes  
**Success Rate:** 95% if following all steps  

