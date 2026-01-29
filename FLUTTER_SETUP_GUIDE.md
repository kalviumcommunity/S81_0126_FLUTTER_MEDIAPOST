# Flutter Environment Setup and Configuration Guide

**Date**: January 29, 2026  
**Project**: Instagram Social Media Application  
**Objective**: Complete Flutter SDK, Android Studio, and Emulator setup for full-stack development

---

## Table of Contents

1. [System Overview](#system-overview)
2. [Flutter SDK Installation](#flutter-sdk-installation)
3. [Android Studio Setup](#android-studio-setup)
4. [Emulator Configuration](#emulator-configuration)
5. [VS Code Configuration](#vs-code-configuration)
6. [Verification Steps](#verification-steps)
7. [First App Deployment](#first-app-deployment)
8. [Troubleshooting](#troubleshooting)
9. [Setup Reflection](#setup-reflection)

---

## System Overview

### Current Environment Status

| Component | Status | Location |
|-----------|--------|----------|
| **Flutter SDK** | ✅ Installed | `C:\src\flutter` |
| **Flutter Version** | 3.19.6 | Stable Channel |
| **Dart Version** | 3.3.4 | Bundled with Flutter |
| **VS Code** | ✅ Installed | 1.108.2 |
| **VS Code Flutter Extension** | ✅ Installed | 3.126.0 |
| **Android Studio** | ❌ Pending | Required |
| **Android SDK** | ❌ Pending | Required |
| **Android Virtual Device** | ❌ Pending | Required |
| **Windows Version** | ✅ 10+ | Build 26200.7623 |
| **Chrome** | ✅ Installed | 144.0.7559.97 |

---

## Flutter SDK Installation

### Step 1: Download Flutter SDK

Flutter SDK is already installed at `C:\src\flutter`. To verify:

```bash
# Check Flutter version
flutter --version

# Expected output:
# Flutter 3.19.6 • channel stable • https://github.com/flutter/flutter.git
# Framework • revision 54e66469a9 (1 year, 9 months ago) • 2024-04-17 13:08:03 -0700
# Engine • revision c4cd48e186
# Tools • Dart 3.3.4
```

### Step 2: Verify PATH Configuration

Flutter should be in your system PATH. Verify:

```bash
# In PowerShell/CMD, check if flutter is accessible globally
flutter doctor

# If not recognized globally, add to PATH:
# 1. Search for "Edit environment variables" in Windows
# 2. Click "Environment Variables..."
# 3. Under "System variables", click "New"
# 4. Variable name: FLUTTER_HOME
#    Variable value: C:\src\flutter
# 5. Edit "Path" variable and add: %FLUTTER_HOME%\bin
# 6. Click OK and restart terminal
```

### Step 3: Initialize Flutter (if new project)

```bash
# Create a new Flutter project
flutter create <project_name>

# Or navigate to existing project
cd d:\instagram\instagram

# Get all dependencies
flutter pub get
```

### Verification

```bash
# Check installation completeness
flutter doctor

# Get detailed information
flutter doctor -v

# List available devices
flutter devices
```

---

## Android Studio Setup

### Step 1: Download and Install Android Studio

1. **Visit** [Android Studio Official Site](https://developer.android.com/studio)
2. **Download** the latest version (Android Studio Koala or later)
3. **Run** the installer

### Step 2: Configure Android Studio During Installation

During the setup wizard, ensure you **select** all required components:

- ✅ Android SDK
- ✅ Android SDK Platform
- ✅ Android Virtual Device (AVD)
- ✅ Android SDK Tools

**Installation Path**: Default (`C:\Program Files\Android\Sdk`)

### Step 3: Install Flutter and Dart Plugins

After Android Studio launches:

1. **Open** `File` → `Settings` (or `Android Studio` → `Preferences` on macOS)
2. **Navigate** to `Plugins`
3. **Search** for "Flutter"
4. **Click** `Install` (this will automatically install Dart plugin too)
5. **Restart** Android Studio

### Step 4: Configure Android SDK

1. **Open** `File` → `Settings` → `Languages & Frameworks` → `Android SDK`
2. **Verify** SDK Platforms tab shows:
   - ✅ Android 13 (API 33) or higher
   - ✅ Android 12 (API 31) or higher
3. **Verify** SDK Tools tab includes:
   - ✅ Android SDK Build-Tools
   - ✅ Android SDK Platform-Tools
   - ✅ Android Emulator

### Configuration Commands

After installation, configure Flutter to use Android SDK:

```bash
# Configure Android SDK location
flutter config --android-sdk C:\Program Files\Android\Sdk

# Verify configuration
flutter config

# Expected output should show:
# android-sdk = C:\Program Files\Android\Sdk
```

---

## Emulator Configuration

### Step 1: Create Virtual Device (AVD)

1. **Open** Android Studio
2. **Click** `Tools` → `Device Manager`
3. **Click** `Create Virtual Device`
4. **Choose Device** (recommended: Pixel 6)
5. **Select System Image**: Android 13 (API 33) or higher
6. **Configure** hardware properties:
   - RAM: 4GB+
   - Internal Storage: 2GB+
   - SD Card: 512MB+
7. **Click** `Finish`

### Step 2: Launch Emulator

Option A - From Android Studio:
```
Tools → Device Manager → Click Play icon next to device
```

Option B - From Command Line:
```bash
# List all available virtual devices
emulator -list-avds

# Launch a specific emulator
emulator -avd <device_name>

# Example:
emulator -avd Pixel_6_API_33
```

### Step 3: Verify Flutter Recognition

```bash
# Check if emulator is recognized
flutter devices

# Expected output:
# emulator-5554                                    • emulator-5554  • generic_x86_64 • Android 13 (API 33)
# Windows (desktop)                                • windows        • windows-x64    • Microsoft Windows [Version ...]
```

---

## VS Code Configuration

### Step 1: Install Extensions

1. **Open** VS Code
2. **Go to** Extensions Marketplace (`Ctrl + Shift + X`)
3. **Search** and install:
   - **Flutter** (by Dart Code) - v3.126.0+
   - **Dart** (by Dart Code) - automatically installed
   - **Awesome Flutter Snippets** (optional)
   - **Better Comments** (optional)

### Step 2: Configure VS Code Settings

Create or update `.vscode/settings.json`:

```json
{
  "[dart]": {
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": "explicit",
      "source.organizeImports": "explicit"
    },
    "editor.rulers": [80, 120]
  },
  "dart.flutterSdkPath": "C:/src/flutter",
  "dart.sdkPath": "C:/src/flutter/bin/cache/dart-sdk",
  "dart.lineLength": 120,
  "dart.enableSdkFormatter": true,
  "editor.defaultFormatter": "dart-code.dart-code",
  "dart.checkForSdkUpdates": true
}
```

### Step 3: Set Up Launch Configurations

Create `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter App",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "console": "integratedTerminal",
      "args": [
        "--dart-define=ENV=development"
      ]
    },
    {
      "name": "Flutter Tests",
      "request": "launch",
      "type": "dart",
      "program": "test",
      "console": "integratedTerminal"
    },
    {
      "name": "Flutter Web",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": [
        "-d",
        "chrome"
      ]
    }
  ]
}
```

---

## Verification Steps

### Step 1: Run Flutter Doctor

```bash
flutter doctor

# Expected output (after all setup):
[√] Flutter
[√] Windows Version
[√] Android toolchain
[√] Android Studio
[√] VS Code
[√] Chrome
[√] Connected devices
[√] Network resources
```

### Step 2: Verify Device Connection

```bash
# List all available devices
flutter devices

# Should show:
# - Android emulator (when running)
# - Windows desktop
# - Chrome (web)
# - Edge (web)
```

### Step 3: Check Android SDK Configuration

```bash
# Verify Android SDK path
flutter config

# Check specific Android SDK components
sdkmanager --list_installed

# Verify build tools
ls "C:\Program Files\Android\Sdk\build-tools"
```

### Step 4: Test Project Setup

```bash
# Navigate to project
cd d:\instagram\instagram

# Get dependencies
flutter pub get

# Analyze code
flutter analyze

# Run tests
flutter test

# Check for issues
flutter doctor --android-licenses
```

---

## First App Deployment

### Step 1: Ensure Emulator is Running

```bash
# Option 1: Launch from Android Studio
# Tools → Device Manager → Click Play button

# Option 2: Launch from command line
emulator -avd Pixel_6_API_33

# Verify emulator is recognized
flutter devices
```

### Step 2: Deploy App to Emulator

```bash
# Navigate to project directory
cd d:\instagram\instagram

# Run on connected device/emulator
flutter run

# With verbose output for debugging
flutter run -v

# Run in release mode (optimized)
flutter run --release

# Run with debug info
flutter run --debug
```

### Step 3: Expected Output

```
Using hardware rendering with device AOSP on ARM Emulator.
Launching lib\main.dart on emulator-5554 in debug mode...
...
Syncing files to device emulator-5554... 
...
✓ Built build/app/outputs/apk/debug/app-debug.apk.
Installing build/app/outputs/apk/debug/app-debug.apk...
✓ Installed build/app/outputs/apk/debug/app-debug.apk.
Launching lib/main.dart on emulator-5554...
✓ Synced 2 new service extensions.
The Flutter DevTools debugger and profiler is available at: http://localhost:9100?token=...
```

### Step 4: Hot Reload and Hot Restart

Once app is running:

```bash
# Hot Reload (keeps app state)
Press 'r' and Enter

# Hot Restart (restarts app)
Press 'R' and Enter

# Show debug info overlay
Press 'p' and Enter

# Screenshot
Press 's' and Enter

# Quit
Press 'q' and Enter
```

---

## Troubleshooting

### Issue 1: Android SDK Not Found

**Error**: `Unable to locate Android SDK`

**Solution**:
```bash
# Set Android SDK path
flutter config --android-sdk "C:\Program Files\Android\Sdk"

# Verify
flutter config | grep android-sdk

# Accept licenses
flutter doctor --android-licenses
```

### Issue 2: No Devices Found

**Error**: `No connected devices`

**Solution**:
```bash
# Start emulator
emulator -avd Pixel_6_API_33

# Wait 10-15 seconds, then check
flutter devices

# If still not recognized, restart adb
adb kill-server
adb start-server
flutter devices
```

### Issue 3: Build Cache Issues

**Error**: Build fails with cache-related errors

**Solution**:
```bash
# Clean build cache
flutter clean

# Get fresh dependencies
flutter pub get

# Rebuild
flutter run
```

### Issue 4: Emulator Crashes or Hangs

**Error**: Emulator becomes unresponsive

**Solution**:
```bash
# Kill emulator process
adb emu kill

# Or from Android Studio
# Tools → Device Manager → Stop button

# Restart emulator
emulator -avd Pixel_6_API_33 -wipe-data
```

### Issue 5: Dart Analysis Errors

**Error**: Red squiggly lines in editor, code analysis issues

**Solution**:
```bash
# Analyze project
flutter analyze

# Get dependencies
flutter pub get

# Clean analysis cache
flutter clean && flutter pub get

# Restart VS Code
# Ctrl + Shift + P → Dart: Restart Analysis Server
```

### Issue 6: Hot Reload Not Working

**Error**: Changes don't reflect after hot reload

**Solution**:
```bash
# Use Hot Restart instead
Press 'R' in terminal

# Or stop and restart
flutter run

# If still issues, clean everything
flutter clean
flutter pub get
flutter run -v
```

---

## Setup Reflection

### Key Learnings

#### 1. **Environment Configuration is Critical**
The development environment setup is foundational for productivity. Proper configuration of Flutter, Android SDK, and IDE integration ensures smooth development workflow without constant troubleshooting.

#### 2. **Multiple Development Paths Available**
Flutter supports multiple development approaches:
- **Android Studio** for full IDE integration and hardware debugging
- **VS Code** for lightweight, fast development
- **Command Line** for CI/CD and automation
- **Physical Devices** for real-world testing

The choice depends on project needs and developer preference. This project uses VS Code with command-line tools for flexibility.

#### 3. **Emulator Performance Matters**
Android Virtual Device (AVD) performance significantly impacts development speed. Key considerations:
- **API Level**: Use Android 13+ for latest features and security
- **RAM Allocation**: 4GB+ ensures smooth operation
- **Hardware Acceleration**: Uses host CPU for 5-10x faster emulation
- **Cold Boot vs. Quick Boot**: Quick Boot saves 20-30 seconds on startup

#### 4. **Device Recognition Challenges**
ADB (Android Debug Bridge) communication can be flaky. Understanding the debug bridge stack helps troubleshoot:
```
Flutter ↔ ADB ↔ Emulator
  (commands)    (socket)
```

### Challenges Faced and Solutions

| Challenge | Root Cause | Solution |
|-----------|-----------|----------|
| **Android SDK Not Found** | Missing Android Studio or wrong path | Explicit `flutter config --android-sdk` command |
| **Emulator Not Recognized** | ADB server crashes or emulator hung | Restart adb with `adb kill-server && adb start-server` |
| **Build Cache Corruption** | Incomplete previous builds | `flutter clean && flutter pub get` |
| **Hot Reload Timeout** | Large app or slow emulator | Use Hot Restart or full rebuild |
| **PATH Not Updated** | Windows environment not refreshed | Close and reopen terminal after PATH modification |

### Development Workflow Benefits

✅ **Fast Iteration**: Hot reload enables code changes in <500ms  
✅ **Real-time Debugging**: DevTools for performance, memory, network analysis  
✅ **Cross-platform**: Single codebase for Android, iOS, Web, Windows  
✅ **Hot UI Testing**: Modify widgets and see results immediately  
✅ **Productivity**: No recompile-redeploy cycle needed for most changes  

### Preparation for Firebase Integration

This environment setup serves as the foundation for:
1. **Firebase Project Integration**: Connected devices needed for testing
2. **Authentication Testing**: Emulator for signup/login flows
3. **Firestore Operations**: Real-time database syncing testing
4. **Push Notifications**: Configured emulator required for testing
5. **File Storage**: Firebase Storage testing on device
6. **Performance Testing**: Emulator metrics collection

---

## Next Steps

### Immediate (This Session)
- [ ] Install Android Studio from official website
- [ ] Create Android Virtual Device (Pixel 6, API 33+)
- [ ] Run `flutter doctor` to verify all setup
- [ ] Launch first app on emulator
- [ ] Take screenshots of setup verification

### Short-term (This Week)
- [ ] Create physical device testing setup
- [ ] Configure release builds
- [ ] Set up CI/CD pipeline
- [ ] Add more launch configurations
- [ ] Document device-specific issues

### Long-term (Next Sprint)
- [ ] Add iOS development setup (if on macOS)
- [ ] Configure Windows desktop app development
- [ ] Set up web development environment
- [ ] Performance profiling and optimization
- [ ] Automated testing infrastructure

---

## Resources

### Official Documentation
- [Flutter Official Website](https://flutter.dev)
- [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- [Android Studio Setup Guide](https://developer.android.com/studio)
- [Flutter DevTools Documentation](https://flutter.dev/docs/development/tools/devtools)

### Troubleshooting Resources
- [Flutter GitHub Issues](https://github.com/flutter/flutter/issues)
- [Android Emulator Documentation](https://developer.android.com/studio/run/emulator)
- [ADB Documentation](https://developer.android.com/studio/command-line/adb)

### Community Support
- [Flutter Community](https://flutter.dev/community)
- [Stack Overflow - Flutter Tag](https://stackoverflow.com/questions/tagged/flutter)
- [Reddit - r/FlutterDev](https://www.reddit.com/r/FlutterDev/)

---

## Summary

| Step | Status | Time | Tool |
|------|--------|------|------|
| **Flutter SDK** | ✅ Complete | <5min | Downloaded installer |
| **Android Studio** | 🔄 In Progress | 20-30min | Android official website |
| **Android SDK Setup** | 🔄 In Progress | 15-20min | Android Studio installer |
| **Emulator Config** | 🔄 In Progress | 10-15min | Android Studio AVD Manager |
| **VS Code Setup** | ✅ Complete | 5-10min | VS Code Extensions |
| **First App Run** | 🔄 Ready | 2-3min | `flutter run` |
| **Verification** | 🔄 Ready | 5-10min | Screenshots + flutter doctor |

**Total Setup Time**: ~2-3 hours (mostly downloading and installing)

---

**Created**: January 29, 2026  
**Last Updated**: January 29, 2026  
**Status**: In Progress - Awaiting Android Studio Installation  
