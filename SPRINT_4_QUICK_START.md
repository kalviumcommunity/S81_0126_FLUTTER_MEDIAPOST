# Sprint 4: Quick Start Reference

**Flutter Environment Setup & First Emulator Run**

---

## TL;DR - What You Need to Do

```
1. Download Android Studio          → https://developer.android.com/studio
2. Install Android Studio            → Follow installer, keep defaults
3. Configure Flutter                 → Run 2 commands
4. Create Virtual Device             → Android Studio UI, 5 minutes
5. Launch Emulator & Run App         → flutter run
6. Take Screenshots                  → flutter doctor output + app running
7. Create PR                         → With setup reflection
```

**Total Time**: 2-3 hours (mostly download/install time)

---

## Commands Cheat Sheet

### After Android Studio Installation

```bash
# Configure Flutter with Android SDK
flutter config --android-sdk "C:\Program Files\Android\Sdk"

# Accept Android licenses
flutter doctor --android-licenses

# Verify setup
flutter doctor -v

# List available devices
flutter devices

# Deploy app to emulator
flutter run

# Run with debug info
flutter run -v

# Run in release mode (faster)
flutter run --release
```

### During App Execution

```bash
Press 'r'   → Hot Reload (update code)
Press 'R'   → Hot Restart (restart app)
Press 'p'   → Performance overlay
Press 's'   → Screenshot
Press 'q'   → Quit
```

---

## Documentation Links

**Setup Guides**:
- **[FLUTTER_SETUP_GUIDE.md](FLUTTER_SETUP_GUIDE.md)** - Step-by-step installation
- **[FLUTTER_ENVIRONMENT_SETUP.md](FLUTTER_ENVIRONMENT_SETUP.md)** - Verification checklist
- **[SPRINT_4_SETUP_CHECKLIST.md](SPRINT_4_SETUP_CHECKLIST.md)** - Progress tracking
- **[SPRINT_4_DOCUMENTATION_SUMMARY.md](SPRINT_4_DOCUMENTATION_SUMMARY.md)** - Overview

**Related Documentation**:
- **[FIREBASE_SETUP_GUIDE.md](FIREBASE_SETUP_GUIDE.md)** - Firebase configuration (next)
- **[ARCHITECTURE.md](ARCHITECTURE.md)** - System architecture
- **[README.md](README.md)** - Project overview

---

## Step 1: Download Android Studio

### Direct Download
- Visit: https://developer.android.com/studio
- Download latest stable version (Koala or later)
- Size: ~1.2 GB
- Time: 10-15 minutes (depends on internet)

### Expected File
- **Filename**: `android-studio-2024.1.2.X-windows.exe`
- **Size**: 1.2 GB+
- **Checksum**: Verify if desired (optional)

---

## Step 2: Install Android Studio

### Installation Process

1. **Run the Installer**
   - Double-click downloaded .exe file
   - Accept User Account Control prompt

2. **Follow Setup Wizard**
   - Welcome screen → Click Next
   - Installation Settings → Keep defaults
   - License Agreement → Accept terms

3. **Select Components** (Important)
   - ✅ Android SDK
   - ✅ Android SDK Platform
   - ✅ Android Virtual Device
   - ✅ Android Emulator
   - Keep all checked

4. **Choose Installation Path**
   - Recommended: C:\Program Files\Android\Sdk
   - (Let installer handle this)

5. **Complete Installation**
   - Wait for installation to finish
   - Time: 15-20 minutes

6. **Launch Android Studio**
   - First launch takes time (indexing)
   - Wait 2-3 minutes for completion

---

## Step 3: Install Flutter Plugin

### In Android Studio

1. **Open Plugins**
   - Click `File` → `Settings`
   - Go to `Plugins`

2. **Search for Flutter**
   - Click search box
   - Type "Flutter"
   - Click the Flutter plugin result

3. **Install Plugin**
   - Click `Install` button
   - Dart plugin auto-installs
   - Restart Android Studio when prompted

4. **Verify Installation**
   - `File` → `New` → `New Flutter Project`
   - Should show Flutter project template

---

## Step 4: Configure Flutter

### Run Configuration Commands

```bash
# Open PowerShell or Command Prompt

# Command 1: Set Android SDK path
flutter config --android-sdk "C:\Program Files\Android\Sdk"

# Command 2: Accept licenses
flutter doctor --android-licenses
# Press 'y' and Enter for each license

# Command 3: Verify setup
flutter doctor -v
```

### Expected Output After Commands

```
[√] Flutter (Channel stable, 3.19.6, on Microsoft Windows [Version 10.0...
[√] Android toolchain - develop for Android devices
[√] Android Studio (version 2024.1)
[√] VS Code (version 1.108.2)
[√] Connected devices (3 available)
[√] Network resources

Doctor found 0 issues in 0 categories.
```

---

## Step 5: Create Android Virtual Device

### In Android Studio

1. **Open Device Manager**
   - Click `Tools` → `Device Manager`

2. **Create New Device**
   - Click `Create Virtual Device` button

3. **Choose Device**
   - Select **Pixel 6** (or Pixel 5/7)
   - Click `Next`

4. **Select System Image**
   - Choose **Android 13 (API 33)** or higher
   - Click `Next`
   - (First time: downloads ~800 MB)

5. **Configure Hardware**
   - Leave defaults or adjust:
     - RAM: 4GB+
     - Internal Storage: 2GB
     - SD Card: 512MB
   - Click `Next`

6. **Finish Setup**
   - Review settings
   - Click `Finish`
   - Device appears in Device Manager

---

## Step 6: Launch Emulator & Test App

### Option A: From Android Studio

1. **Open Device Manager**
   - `Tools` → `Device Manager`

2. **Launch Device**
   - Find your device in list
   - Click Play icon (▶)
   - Wait 15-20 seconds for boot

### Option B: From Command Line

```bash
# List available devices
emulator -list-avds

# Launch device
emulator -avd Pixel_6_API_33

# Or if name is different
emulator -avd <exact_device_name>
```

### Test App Deployment

```bash
# Navigate to project
cd d:\instagram\instagram

# Run app on emulator
flutter run

# Expected: App appears on emulator screen after 30-45 seconds

# While app running:
Press 'r' to hot reload
Press 'R' to hot restart
Press 'q' to quit
```

---

## Step 7: Verify Setup Success

### Run Verification Tests

```bash
# Test 1: Flutter Doctor
flutter doctor -v
# Should show all ✓ checks

# Test 2: Device Recognition
flutter devices
# Should show emulator listed

# Test 3: Code Analysis
flutter analyze
# Should show: No issues found!

# Test 4: Run Tests
flutter test
# Should pass all tests

# Test 5: Deploy App
flutter run
# Should launch app on emulator
```

### Success Indicators

✅ `flutter doctor` shows 0 issues  
✅ `flutter devices` lists emulator  
✅ `flutter run` deploys successfully  
✅ Hot reload works (press 'r')  
✅ No analysis errors  
✅ All tests passing  

---

## Step 8: Screenshots Required

### Screenshot 1: Flutter Doctor Output

**Command**:
```bash
flutter doctor -v
```

**Capture**: Full terminal output showing all green checks

**What to highlight**:
- Flutter version 3.19.6
- All components with ✓
- "Doctor found 0 issues"

---

### Screenshot 2: App Running on Emulator

**Command**:
```bash
flutter run
```

**Capture**: Emulator window showing app UI

**What to show**:
- Emulator clearly visible
- App UI displayed
- Android version in status bar

---

### Screenshot 3: VS Code Environment

**Capture**: VS Code with project open

**What to show**:
- Project file tree
- lib/main.dart code
- Syntax highlighting active
- Flutter extension in sidebar

---

### Screenshot 4: Device Manager

**Capture**: Android Studio Device Manager

**What to show**:
- Virtual device listed
- Device specifications
- Launch button available

---

## Troubleshooting Quick Fixes

### Issue: "Android SDK not found"

```bash
# Solution: Set path
flutter config --android-sdk "C:\Program Files\Android\Sdk"
flutter doctor --android-licenses
```

### Issue: "No connected devices"

```bash
# Solution: Restart adb
adb kill-server
adb start-server
flutter devices
```

### Issue: "Build cache issues"

```bash
# Solution: Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### Issue: "Emulator won't start"

```bash
# Solution: Kill and restart
adb emu kill
# Wait 5 seconds, then
emulator -avd Pixel_6_API_33
```

### Issue: "Hot reload timeout"

```bash
# Solution: Use hot restart instead
Press 'R' in terminal
# Or run
flutter run
```

---

## After Setup: Next Steps

### Immediate
1. ✅ Document setup in README.md
2. ✅ Take screenshots of verification
3. ✅ Create PR with setup results

### Short-term (This Week)
1. Test Firebase authentication
2. Test Firestore operations
3. Test real-time data sync

### Medium-term (Next Sprint)
1. Add image upload to Firebase Storage
2. Implement Cloud Functions
3. Add push notifications

---

## Quick Links

| Link | Purpose |
|------|---------|
| [FLUTTER_SETUP_GUIDE.md](FLUTTER_SETUP_GUIDE.md) | Complete installation guide |
| [FLUTTER_ENVIRONMENT_SETUP.md](FLUTTER_ENVIRONMENT_SETUP.md) | Verification checklist |
| [Android Studio](https://developer.android.com/studio) | Official download |
| [Flutter Docs](https://flutter.dev/docs) | Official documentation |
| [GitHub PR](https://github.com/kalviumcommunity/S81_0126_FLUTTER_MEDIAPOST/pull/new/feature/flutter-environment-setup) | Submit setup results |

---

## Timeline

| Step | Time | Status |
|------|------|--------|
| **Download Android Studio** | 10-15 min | ⏳ Next |
| **Install Android Studio** | 15-20 min | ⏳ Next |
| **Configure Flutter** | 2-3 min | ⏳ Next |
| **Create Emulator** | 10-15 min | ⏳ Next |
| **Test Deployment** | 5-10 min | ⏳ Next |
| **Capture Screenshots** | 5-10 min | ⏳ Next |
| **Documentation** | 5-10 min | ⏳ Next |
| **Create PR** | 5-10 min | ⏳ Next |
| **TOTAL** | **~2-3 hours** | 🔄 Ready |

---

## Current Status

✅ Documentation complete (9000+ words)  
✅ Code examples provided (15+)  
✅ Troubleshooting guide ready (20+ scenarios)  
🔄 Ready for physical installation (Android Studio download)  
🔄 Ready for testing (emulator + app deployment)  
🔄 Ready for verification (flutter doctor + screenshots)  

---

**Next Action**: Download Android Studio and follow FLUTTER_SETUP_GUIDE.md step-by-step.

**Questions?** Refer to [FLUTTER_SETUP_GUIDE.md](FLUTTER_SETUP_GUIDE.md) for detailed instructions or troubleshooting section for common issues.

---

**Created**: January 29, 2026  
**Status**: 🔄 IN PROGRESS - Ready for Phase 2 (Installation)  
