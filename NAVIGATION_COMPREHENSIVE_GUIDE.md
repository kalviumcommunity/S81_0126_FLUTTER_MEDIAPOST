# Multi-Screen Navigation Using Navigator and Routes - Sprint #2 Guide

## 📚 Table of Contents
1. [Introduction](#introduction)
2. [Navigator Overview](#navigator-overview)
3. [Stack-Based Model](#stack-based-model)
4. [Navigation Methods](#navigation-methods)
5. [Named Routes](#named-routes)
6. [Data Passing](#data-passing)
7. [Code Examples](#code-examples)
8. [Best Practices](#best-practices)
9. [Complete Implementation](#complete-implementation)

---

## 🎯 Introduction

Navigation is a fundamental concept in Flutter that allows users to move between different screens in your application. Flutter provides a powerful `Navigator` widget that manages an app's screens using a stack-based model, similar to how web browsers manage page history.

### Why Navigation Matters
- **User Flow**: Guides users through your app experience
- **State Management**: Maintains screen stack for back navigation
- **Data Transfer**: Passes data between screens seamlessly
- **Deep Linking**: Supports navigation via URLs/intents
- **User Experience**: Smooth transitions between screens

### Learning Objectives
By the end of this guide, you'll understand:
- How the Navigator stack works
- Different navigation methods (push, pop, named routes)
- How to pass data between screens
- Best practices for scalable navigation
- Real-world implementation patterns

---

## 🧭 Navigator Overview

### What is Navigator?

The `Navigator` widget is Flutter's primary tool for managing app screens. It maintains a **stack** of `Route` objects, where each route typically represents a screen.

### Basic Concepts

**Route**: A representation of a screen or page in your app
```dart
// Simple route using MaterialPageRoute
MaterialPageRoute(builder: (context) => MyScreen())
```

**Navigator**: The widget that manages the stack of routes
```dart
// Access the Navigator via context
Navigator.of(context)
```

### Route Types

| Route Type | Use Case | Example |
|-----------|----------|---------|
| **MaterialPageRoute** | Default iOS-style slides right, Android-style fades | Platform-appropriate animations |
| **CupertinoPageRoute** | iOS-style slide from right | iOS apps |
| **PageRouteBuilder** | Custom animations | Custom transitions |
| **Named Route** | String-based route references | '/details', '/profile' |

---

## 📚 Stack-Based Model

### How the Stack Works

The Navigator maintains a **Last-In-First-Out (LIFO)** stack of routes. New screens are pushed on top, and removed screens are popped from the stack.

### Stack Visualization

```
Initial State:
    ┌─────────────────┐
    │   Home Screen   │  ← Active (top of stack)
    └─────────────────┘

After Navigator.push():
    ┌─────────────────┐
    │ Details Screen  │  ← Active (top of stack)
    ├─────────────────┤
    │   Home Screen   │
    └─────────────────┘

After Navigator.pop():
    ┌─────────────────┐
    │   Home Screen   │  ← Active (top of stack)
    └─────────────────┘
```

### Stack Operations

```dart
// PUSH: Add new route to stack (move forward)
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => DetailsScreen()),
);

// POP: Remove current route from stack (go back)
Navigator.pop(context);

// REPLACE: Replace top route with new one
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => NewScreen()),
);

// POP UNTIL: Remove routes until condition is met
Navigator.popUntil(context, (route) => route.isFirst);

// PUSH AND REMOVE UNTIL: Push new route and remove until condition
Navigator.pushNamedAndRemoveUntil(
  context,
  '/home',
  (route) => false, // Remove all routes
);
```

### Key Points
- **First Route**: Initial screen pushed when app starts
- **Stack Order**: Last pushed route is at the top (active)
- **Back Button**: Automatically calls `Navigator.pop()`
- **Android Back**: System back button triggers pop
- **iOS Gesture**: Left edge swipe triggers pop

---

## 🔄 Navigation Methods

### 1. Navigator.push()

**Purpose**: Push a new route on top of the current one

```dart
// Simple push
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const DetailsScreen(),
  ),
);

// With page builder shortcut
Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => const DetailsScreen()),
);
```

**Use Cases**:
- Navigate to a detail page
- Open a settings screen
- Go to the next step in a flow

### 2. Navigator.pop()

**Purpose**: Remove the current route and return to previous screen

```dart
// Simple pop
Navigator.pop(context);

// Pop with return value (for data passing back)
Navigator.pop(context, 'returned data');

// In AppBar (automatic)
AppBar(
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
  ),
)
```

**Use Cases**:
- Go back to previous screen
- Return data to caller
- Close a dialog

### 3. Navigator.pushNamed()

**Purpose**: Push a named route (requires route configuration)

```dart
// In main.dart
MaterialApp(
  routes: {
    '/': (context) => const HomeScreen(),
    '/details': (context) => const DetailsScreen(),
  },
)

// In any screen
Navigator.pushNamed(context, '/details');
```

**Use Cases**:
- Use string identifiers for routes
- Centralized route management
- Easier to refactor

### 4. Navigator.pushReplacement()

**Purpose**: Remove current route and push new one

```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const AuthScreen()),
);
```

**Use Cases**:
- After login (don't allow back to login)
- Splash screen → home transition
- One-way navigation flows

### 5. Navigator.popUntil()

**Purpose**: Pop routes until a condition is met

```dart
// Pop until home screen (first route)
Navigator.popUntil(context, (route) => route.isFirst);

// Pop until specific named route
Navigator.popUntil(
  context,
  ModalRoute.withName('/home'),
);

// Pop back 2 screens
int popCount = 0;
Navigator.popUntil(context, (route) {
  return popCount++ >= 2;
});
```

**Use Cases**:
- Multi-level back navigation
- Skip multiple screens at once
- Return to specific point in stack

### 6. Navigator.pushNamedAndRemoveUntil()

**Purpose**: Push new named route and remove others

```dart
// Clear stack and push home
Navigator.pushNamedAndRemoveUntil(
  context,
  '/',
  (route) => false, // Remove all
);

// Keep only home, push new
Navigator.pushNamedAndRemoveUntil(
  context,
  '/details',
  (route) => route.isFirst, // Keep first only
);
```

**Use Cases**:
- Logout flow (return to login)
- Deep link handling
- Reset app state

---

## 🏷️ Named Routes

### Defining Routes

**In main.dart**:
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: const HomeScreen(),
      routes: {
        // Route name: route builder
        '/': (context) => const HomeScreen(),
        '/details': (context) => const DetailsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
```

### Using Named Routes

```dart
// Navigate using route name
Navigator.pushNamed(context, '/details');

// Pop back (automatic for named routes)
Navigator.pop(context);

// Check current route name
String? currentRoute = ModalRoute.of(context)?.settings.name;
```

### Advantages of Named Routes
✅ Centralized route management
✅ Easier to maintain
✅ Prevents typos (route names are constants)
✅ Supports deep linking
✅ Better for large apps

### Best Practice: Route Constants

```dart
// lib/routes/app_routes.dart
class AppRoutes {
  static const String home = '/';
  static const String details = '/details';
  static const String profile = '/profile';
  static const String settings = '/settings';
}

// Usage
Navigator.pushNamed(context, AppRoutes.details);
```

---

## 📤 Data Passing

### Method 1: Constructor Parameters

**Passing Data Forward**:
```dart
// Option A: Push with MaterialPageRoute
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailScreen(userId: 123),
  ),
);

// Receiving in DetailScreen
class DetailScreen extends StatelessWidget {
  final int userId;
  const DetailScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('User: $userId'),
    );
  }
}
```

### Method 2: Named Routes with Arguments

**Passing Data Forward**:
```dart
// Push with arguments
Navigator.pushNamed(
  context,
  '/profile',
  arguments: 'user_data', // Can be String, Map, Object, etc.
);

// Access in ProfileScreen
final userData = ModalRoute.of(context)?.settings.arguments as String?;
```

**Complete Example**:
```dart
// Define route
routes: {
  '/profile': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    return ProfileScreen(
      userId: args?['userId'] ?? '',
      userName: args?['userName'] ?? '',
    );
  }
}

// Navigate with arguments
Navigator.pushNamed(
  context,
  '/profile',
  arguments: {
    'userId': '123',
    'userName': 'John Doe',
  },
);
```

### Method 3: Returning Data

**Passing Data Backward**:
```dart
// Home Screen
final result = await Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const DetailsScreen()),
);

print('Returned: $result'); // 'user_selected'

// Details Screen
Navigator.pop(context, 'user_selected');
```

### Method 4: Shared State/Provider

For complex data passing, use state management:
```dart
// Using Provider
final user = context.watch<UserProvider>().user;

// Navigate
Navigator.pushNamed(context, '/profile');

// Access same data in new screen
final userData = context.read<UserProvider>().user;
```

### Data Passing Patterns

| Pattern | Best For | Complexity |
|---------|----------|-----------|
| **Constructor** | Simple data, typed | Low |
| **Named Routes Args** | Any data type | Medium |
| **Return Values** | Data back to caller | Medium |
| **State Management** | Shared app state | High |
| **URL Parameters** | Deep linking, web | High |

---

## 💻 Code Examples

### Example 1: Simple Navigation

```dart
// HomeScreen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Simple push
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailsScreen(),
              ),
            );
          },
          child: const Text('Go to Details'),
        ),
      ),
    );
  }
}

// DetailsScreen
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text('Details Screen'),
      ),
    );
  }
}
```

### Example 2: Named Routes Navigation

```dart
// main.dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation App',
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) => const DetailsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}

// Navigation
Navigator.pushNamed(context, '/details');
Navigator.pop(context);
```

### Example 3: Passing Data Between Screens

```dart
// Forward: Home → Details
Navigator.pushNamed(
  context,
  '/details',
  arguments: {'id': 123, 'name': 'Product'},
);

// In DetailsScreen
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final id = args?['id'] ?? 0;
    final name = args?['name'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ID: $id'),
            Text('Name: $name'),
          ],
        ),
      ),
    );
  }
}

// Backward: Details → Home
Navigator.pop(context, 'selected_item');

// In Home (waiting for return value)
final result = await Navigator.pushNamed(context, '/details');
print('Selected: $result');
```

### Example 4: Conditional Navigation

```dart
// Navigate based on conditions
void _navigateBasedOnRole(String userRole) {
  if (userRole == 'admin') {
    Navigator.pushNamed(context, '/admin-dashboard');
  } else if (userRole == 'user') {
    Navigator.pushNamed(context, '/user-profile');
  } else {
    Navigator.pushNamed(context, '/login');
  }
}

// Use in callback
ElevatedButton(
  onPressed: () => _navigateBasedOnRole(user.role),
  child: const Text('Navigate'),
)
```

---

## ✅ Best Practices

### 1. Use Named Routes for Large Apps

```dart
// ✅ GOOD: Centralized route management
routes: {
  AppRoutes.home: (context) => const HomeScreen(),
  AppRoutes.details: (context) => const DetailsScreen(),
}

// ❌ BAD: Hardcoded strings scattered
Navigator.pushNamed(context, '/details');
Navigator.pushNamed(context, '/profile');
```

### 2. Create Route Constants

```dart
// ✅ GOOD
class AppRoutes {
  static const home = '/';
  static const details = '/details';
  static const profile = '/profile';
}

Navigator.pushNamed(context, AppRoutes.details);

// ❌ BAD
Navigator.pushNamed(context, '/details'); // Error-prone
```

### 3. Use Type-Safe Arguments

```dart
// ✅ GOOD: Define custom class
class ProfileArgs {
  final String userId;
  final String userName;
  ProfileArgs({required this.userId, required this.userName});
}

// In routes
arguments: ProfileArgs(
  userId: '123',
  userName: 'John',
),

// ❌ BAD: Untyped Map
arguments: {'userId': '123'}, // No type safety
```

### 4. Handle Missing Routes

```dart
// ✅ GOOD: Provide fallback
MaterialApp(
  routes: { /* ... */ },
  onGenerateRoute: (settings) {
    // Handle unknown routes
    return MaterialPageRoute(
      builder: (context) => const NotFoundScreen(),
    );
  },
)

// ❌ BAD: No error handling
MaterialApp(
  routes: { /* ... */ },
)
```

### 5. Avoid Deep Navigation Chains

```dart
// ✅ GOOD: Direct navigation
Navigator.pushNamedAndRemoveUntil(
  context,
  '/home',
  (route) => false,
);

// ❌ BAD: Multiple pushes
Navigator.push(context, ...);
Navigator.push(context, ...);
Navigator.push(context, ...);
```

### 6. Use Async for Return Values

```dart
// ✅ GOOD: Await result
final selected = await Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => SelectionScreen()),
);
// Use selected...

// ❌ BAD: Ignore return value
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => SelectionScreen()),
);
```

### 7. Debug Route Navigation

```dart
// ✅ GOOD: Add debugging
debugPrint('📍 Navigating to /details');
Navigator.pushNamed(context, '/details');

// Add observer
observersMaterialApp(
  navigatorObservers: [
    NavigatorObserver(), // Custom observer
  ],
)
```

### 8. Handle Back Button Properly

```dart
// ✅ GOOD: Override WillPopScope
WillPopScope(
  onWillPop: () async {
    // Handle back button
    return true; // Allow pop
  },
  child: Scaffold( /* ... */ ),
)

// ❌ BAD: Ignore system back
Scaffold(
  body: Center(
    child: Text('No back button'), // Confusing
  ),
)
```

---

## 📋 Complete Implementation

### Project Structure

```
lib/
├── main.dart                          # App entry, routes
├── routes/
│   └── app_routes.dart                # Route constants
├── screens/
│   ├── navigation_home_screen.dart    # Navigation hub
│   ├── details_screen.dart            # Details
│   ├── navigation_profile_screen.dart # Profile with data
│   ├── navigation_settings_screen.dart # Settings
│   └── navigation_nested_screen.dart  # Nested nav
└── models/
    └── user_model.dart                # Data models
```

### File: lib/routes/app_routes.dart

```dart
class AppRoutes {
  static const String home = '/';
  static const String navigationHub = '/navigation';
  static const String details = '/details';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String nested = '/nested';
}
```

### File: lib/models/user_model.dart

```dart
class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });
}
```

### File: lib/main.dart (Navigation Setup)

```dart
import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'screens/navigation_home_screen.dart';
import 'screens/details_screen.dart';
import 'screens/navigation_profile_screen.dart';
import 'screens/navigation_settings_screen.dart';
import 'screens/navigation_nested_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const NavigationHomeScreen(),
      routes: {
        AppRoutes.navigationHub: (context) => const NavigationHomeScreen(),
        AppRoutes.details: (context) => const DetailsScreen(),
        AppRoutes.profile: (context) => const NavigationProfileScreen(),
        AppRoutes.settings: (context) => const SettingsScreen(),
        AppRoutes.nested: (context) => const NestedNavigationScreen(),
      },
      onGenerateRoute: (settings) {
        // Handle dynamic routes or unknown routes
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(
              child: Text('Route not found'),
            ),
          ),
        );
      },
    );
  }
}
```

---

## 🚀 Advanced Topics

### Custom Transitions

```dart
// Custom page transition
class CustomPageRoute extends PageRoute {
  final Widget child;
  
  CustomPageRoute({required this.child});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}

// Usage
Navigator.push(context, CustomPageRoute(child: DetailsScreen()));
```

### Navigator Observer (Analytics/Debugging)

```dart
class NavigationObserver extends RouteObserver<PageRoute> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('Navigation: Pushed ${route.toString()}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('Navigation: Popped ${route.toString()}');
  }
}

// In main.dart
MaterialApp(
  navigatorObservers: [NavigationObserver()],
)
```

### Deep Linking

```dart
MaterialApp(
  onGenerateRoute: (settings) {
    if (settings.name?.startsWith('/user/') ?? false) {
      final userId = settings.name!.split('/')[2];
      return MaterialPageRoute(
        builder: (_) => UserScreen(userId: userId),
      );
    }
    return null;
  },
)
```

---

## 📊 Navigation Decision Tree

```
Need to navigate?
│
├─→ Know the route name? → Use Navigator.pushNamed()
│
├─→ Need to pass data? → Add arguments parameter
│                         ↓
│                    Can you wait for result?
│                    ├─→ Yes → Use await pushNamed()
│                    └─→ No → Use arguments
│
├─→ Need to replace current screen? → Use pushReplacement()
│
├─→ Need to skip multiple screens? → Use popUntil()
│
└─→ Need to clear navigation stack? → Use pushNamedAndRemoveUntil()
```

---

## 🎓 Key Takeaways

1. **Navigator Stack**: Think of routes like a stack of papers
2. **Push/Pop**: Add (push) and remove (pop) routes from the stack
3. **Named Routes**: Centralize route definitions in main.dart
4. **Data Passing**: Use arguments with pushNamed() or constructor params
5. **Return Values**: Use await with push() for two-way communication
6. **Back Navigation**: Automatic via back button or Navigator.pop()
7. **Best Practices**: Constants, type safety, error handling
8. **Testing**: Use test routes with mock navigation

---

## 📚 Additional Resources

- [Flutter Navigation Documentation](https://flutter.dev/docs/development/ui/navigation)
- [Navigator API Reference](https://api.flutter.dev/flutter/widgets/Navigator-class.html)
- [Routing and Navigation Tutorial](https://codelabs.developers.google.com/codelabs/flutter)

---

## 🎉 Summary

You've learned:
- ✅ How Navigator's stack-based model works
- ✅ All major navigation methods (push, pop, pushNamed, etc.)
- ✅ How to define and use named routes
- ✅ Multiple data passing patterns
- ✅ Best practices for scalable navigation
- ✅ Real-world implementation examples

Now you can build complex multi-screen Flutter apps with confident navigation! 🚀
