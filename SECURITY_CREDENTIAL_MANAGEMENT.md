# Firebase Security & Credential Management Guide

**Date**: January 29, 2026  
**Status**: ⚠️ Security Update Required

---

## 🚨 CRITICAL: Credential Exposure

Your Firebase credentials are currently **exposed in GitHub**. This is a security vulnerability.

### Immediate Actions Required:

#### Step 1: Regenerate Firebase Credentials
1. Go to https://console.firebase.google.com
2. Select project: `s81-0126-flutter-mediapost`
3. Go to **Project Settings** → **Service Accounts**
4. Generate new credentials
5. **Old credentials are compromised and should not be used**

#### Step 2: Secure Credential Management

**DO NOT:**
- ❌ Commit credentials to Git
- ❌ Hardcode API keys in source code
- ❌ Share credentials in documentation
- ❌ Include credentials in version control

**DO:**
- ✅ Use environment variables (.env files)
- ✅ Use Firebase config files (not in Git)
- ✅ Use CI/CD secrets for deployment
- ✅ Regenerate keys regularly
- ✅ Monitor Firebase console for unauthorized access

---

## 🔐 Secure Firebase Configuration Setup

### Method 1: Environment Variables (Development)

Create a `.env` file (add to .gitignore):

```
FIREBASE_API_KEY=your_api_key_here
FIREBASE_APP_ID=your_app_id_here
FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_STORAGE_BUCKET=your-project.appspot.com
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
```

Update `lib/firebase_options.dart`:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static FirebaseOptions get currentPlatform {
    return FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY']!,
      appId: dotenv.env['FIREBASE_APP_ID']!,
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
      projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
      authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN']!,
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
    );
  }
}
```

### Method 2: Platform-Specific Config (Recommended)

#### For Android (`android/app/google-services.json`):
- Download from Firebase Console
- Add to `.gitignore`
- Do NOT commit to Git

#### For iOS (`ios/Runner/GoogleService-Info.plist`):
- Download from Firebase Console
- Add to `.gitignore`
- Do NOT commit to Git

#### For Web (`web/firebase-config.js`):
```javascript
// ⚠️ Web API keys are PUBLIC by design
// Use Firebase Security Rules to protect data
const firebaseConfig = {
  apiKey: "AIza....", // This is meant to be public
  // ...
};
```

---

## 🛡️ Firebase Security Rules

### Firestore Security Rules (CRITICAL)

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Deny all by default
    match /{document=**} {
      allow read, write: if false;
    }
    
    // Users can only read/write their own data
    match /users/{uid} {
      allow read, write: if request.auth.uid == uid;
    }
    
    // Posts: read by all authenticated users, write by owner only
    match /posts/{postId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && 
                       request.auth.uid == request.resource.data.uid;
      allow update, delete: if request.auth.uid == resource.data.uid;
    }
    
    // Comments: read by all, write by authenticated users
    match /posts/{postId}/comments/{commentId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth.uid == resource.data.uid;
    }
  }
}
```

### Authentication Security Rules

1. **Email/Password**: ✅ Enabled
2. **Password Requirements**:
   - Minimum 6 characters (configure in Firebase)
   - Recommend: 8+ with mixed case and numbers

3. **Session Management**:
   - Automatic token refresh
   - No long-lived tokens in frontend

---

## 📋 Credential Handling Checklist

| Item | Status | Action |
|------|--------|--------|
| Real credentials in GitHub | ⚠️ EXPOSED | Regenerate immediately |
| .env file created | ❌ NO | Create and add to .gitignore |
| firebase_options.dart in .gitignore | ❌ NO | Add to .gitignore |
| google-services.json in .gitignore | ❌ NO | Add to .gitignore |
| Security rules configured | ⚠️ INCOMPLETE | Update Firestore rules |
| Environment variables used | ❌ NO | Implement dotenv |
| Documentation shows real credentials | ⚠️ YES | Update docs |
| Credentials rotated | ❌ NO | Regenerate new ones |

---

## 🚀 Implementation Steps

### Step 1: Add to .gitignore

```
# Firebase Configuration (SECURITY CRITICAL)
lib/firebase_options.dart
.env
.env.local
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
web/firebase-config.js
```

### Step 2: Install flutter_dotenv

```bash
flutter pub add flutter_dotenv
```

### Step 3: Create .env.example

```
# Copy this file to .env and fill with your values
FIREBASE_API_KEY=your_api_key_here
FIREBASE_APP_ID=your_app_id_here
FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_STORAGE_BUCKET=your-project.appspot.com
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
```

### Step 4: Update main.dart

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseConfig.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  runApp(const MyApp());
}
```

### Step 5: Update pubspec.yaml

```yaml
flutter_dotenv: ^5.1.0
```

### Step 6: Remove Exposed Credentials

Run these commands:
```bash
# Remove the file from Git history (but keep in local)
git rm --cached lib/firebase_options.dart
git commit -m "security: remove firebase credentials from version control"
git push
```

---

## 📝 Documentation Best Practices

### ❌ DO NOT Document:
- API keys
- App IDs
- Project IDs
- Service account credentials
- Any secrets or sensitive data

### ✅ DO Document:
- How to set up credentials securely
- Where to get credentials (Firebase Console link)
- Which environment variables are needed
- Security rules and policies
- Best practices for handling secrets

---

## 🔄 Team/Production Setup

### For Developers:
1. Get real `.env` file from team lead (NOT in Git)
2. Or create `.env` with own Firebase project
3. Copy `.env.example` to `.env`
4. Fill with their own credentials

### For CI/CD (GitHub Actions):
```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    env:
      FIREBASE_API_KEY: ${{ secrets.FIREBASE_API_KEY }}
      FIREBASE_PROJECT_ID: ${{ secrets.FIREBASE_PROJECT_ID }}
      # ... other secrets
```

### For Production:
1. Create separate Firebase project for production
2. Use different credentials than development
3. Rotate credentials every 90 days
4. Monitor Firebase console for suspicious activity
5. Enable 2FA on Firebase account

---

## 🚨 What Happened (Timeline)

| Date | Action | Risk |
|------|--------|------|
| 2026-01-29 | Real credentials added to code | ⚠️ HIGH |
| 2026-01-29 | Committed to GitHub | 🔴 CRITICAL |
| 2026-01-29 | Visible in public documentation | 🔴 CRITICAL |
| NOW | Need immediate remediation | 🔴 URGENT |

---

## 🛠️ Remediation Plan

### Immediate (Today):
1. ✅ Regenerate Firebase credentials
2. ✅ Create .env file locally
3. ✅ Add to .gitignore
4. ✅ Update code to use env vars
5. ✅ Remove from Git history
6. ✅ Update documentation

### Short Term:
1. Review Firebase Security Rules
2. Enable API restrictions
3. Set up monitoring/alerts
4. Document secure setup for team

### Ongoing:
1. Monthly credential rotation
2. Regular security audits
3. Team training on credential handling
4. Automated secrets scanning

---

## 📚 References

- [Firebase Security Best Practices](https://firebase.google.com/docs/security)
- [Firestore Security Rules](https://firebase.google.com/docs/firestore/security/start)
- [Flutter Security](https://flutter.dev/security)
- [OWASP: Secrets Management](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)

---

## ✅ Resolution Status

**Priority**: 🔴 **CRITICAL**  
**Effort**: Medium (1-2 hours)  
**Risk if not fixed**: EXTREME (compromised Firebase project)  

**Action Required**: Implement secure credential handling immediately.

