# Sprint 6: Best Practices & Implementation Guide

## Overview

This guide covers best practices for implementing user input forms in Flutter, with real-world examples from the Sprint 6 implementation.

---

## 1. Form Structure Best Practices

### ✅ DO: Use Separate StatefulWidget for Forms

```dart
class MyFormScreen extends StatefulWidget {
  const MyFormScreen({Key? key}) : super(key: key);

  @override
  State<MyFormScreen> createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  // State here
}
```

**Why**: Keeps form state isolated and makes testing easier.

### ✅ DO: Always Use GlobalKey<FormState>

```dart
final _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
  return Form(
    key: _formKey,
    child: // fields
  );
}

void _submit() {
  if (_formKey.currentState!.validate()) {
    // Valid!
  }
}
```

**Why**: Allows accessing form state for validation and reset operations.

### ❌ DON'T: Put Forms Directly in StatelessWidget

```dart
// BAD - no state management
class MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(child: // fields);
  }
}
```

---

## 2. Text Field Best Practices

### ✅ DO: Always Provide Descriptive Labels

```dart
TextFormField(
  decoration: InputDecoration(
    labelText: 'Email Address',  // Clear label
    hintText: 'example@email.com',  // Example
    helperText: 'We\'ll never share your email',  // Context
  ),
)
```

**Why**: Improves accessibility and user understanding.

### ✅ DO: Use Appropriate Keyboard Types

```dart
// Email
TextFormField(
  keyboardType: TextInputType.emailAddress,
)

// Phone
TextFormField(
  keyboardType: TextInputType.phone,
)

// Number
TextFormField(
  keyboardType: TextInputType.number,
)

// URL
TextFormField(
  keyboardType: TextInputType.url,
)
```

**Why**: Optimizes keyboard for the input type.

### ✅ DO: Add Prefix Icons for Context

```dart
TextFormField(
  decoration: InputDecoration(
    labelText: 'Email',
    prefixIcon: const Icon(Icons.email),  // Visual context
  ),
)
```

**Why**: Provides visual cues to users about field purpose.

### ❌ DON'T: Use TextField Without Labels

```dart
// BAD - unclear what field is for
TextFormField(
  decoration: InputDecoration(hintText: 'Enter...'),
)

// GOOD
TextFormField(
  decoration: InputDecoration(
    labelText: 'Full Name',
    hintText: 'John Doe',
  ),
)
```

---

## 3. Validation Best Practices

### ✅ DO: Return null for Valid Input

```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';  // Error message
  }
  return null;  // Null = valid
}
```

**Why**: Flutter convention - null means valid, string means error.

### ✅ DO: Provide Specific Error Messages

```dart
// BAD - vague
validator: (v) => v?.isEmpty ?? true ? 'Invalid' : null

// GOOD - specific
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  if (!value.contains('@')) {
    return 'Email must contain @ symbol';
  }
  if (!value.contains('.')) {
    return 'Email must contain domain name';
  }
  return null;
}
```

**Why**: Users know exactly how to fix the error.

### ✅ DO: Validate in Logical Order

```dart
String? validateEmail(String? value) {
  // 1. Check if empty (required validation)
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  
  // 2. Check format (format validation)
  if (!value.contains('@')) {
    return 'Email must contain @';
  }
  
  // 3. Check domain (domain validation)
  if (!value.contains('.')) {
    return 'Email must have a domain';
  }
  
  // 4. Valid
  return null;
}
```

**Why**: Shows users the most important error first.

### ✅ DO: Extract Complex Validators into Separate Methods

```dart
String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Required';
  if (!value.contains('@')) return 'Invalid email';
  return null;
}

String? _validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Required';
  if (value.length < 6) return 'Min 6 characters';
  return null;
}

// In form:
TextFormField(
  validator: _validateEmail,
)

TextFormField(
  validator: _validatePassword,
)
```

**Why**: Reusable, testable, readable code.

### ✅ DO: Use Regular Expressions for Complex Patterns

```dart
final emailRegex = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
);

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Required';
  if (!emailRegex.hasMatch(value)) return 'Invalid email format';
  return null;
}
```

**Why**: Precise validation of complex patterns.

### ❌ DON'T: Return Validation Messages in Non-Error Cases

```dart
// BAD - returns message for valid field
validator: (v) => v?.isEmpty ?? true ? 'Required' : 'Valid'

// GOOD - returns null for valid
validator: (v) => v?.isEmpty ?? true ? 'Required' : null
```

---

## 4. Form Submission Best Practices

### ✅ DO: Validate Before Processing

```dart
void _submitForm() {
  // 1. Validate form
  if (!_formKey.currentState!.validate()) {
    return;  // Stop if invalid
  }
  
  // 2. Get values
  final email = _emailController.text;
  final password = _passwordController.text;
  
  // 3. Process form
  _processSubmission(email, password);
}
```

**Why**: Prevents invalid data from reaching your backend.

### ✅ DO: Show Loading State During Submission

```dart
bool _isLoading = false;

void _submitForm() {
  if (!_formKey.currentState!.validate()) return;
  
  setState(() => _isLoading = true);
  
  Future.delayed(const Duration(seconds: 2), () {
    setState(() => _isLoading = false);
    // Handle response
  });
}

// In button:
ElevatedButton(
  onPressed: _isLoading ? null : _submitForm,
  child: _isLoading
      ? const CircularProgressIndicator()
      : const Text('Submit'),
)
```

**Why**: User knows request is processing and prevents multiple submissions.

### ✅ DO: Check mounted Before setState After Async

```dart
Future.delayed(const Duration(seconds: 2), () {
  if (mounted) {  // Check if widget still exists
    setState(() => _isLoading = false);
  }
});
```

**Why**: Prevents "setState called after dispose" errors.

### ✅ DO: Reset Form After Successful Submission

```dart
void _submitForm() {
  if (!_formKey.currentState!.validate()) return;
  
  setState(() => _isLoading = true);
  
  Future.delayed(const Duration(seconds: 2), () {
    setState(() => _isLoading = false);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✓ Submitted successfully!')),
      );
      
      // Reset form for next use
      _formKey.currentState!.reset();
      _emailController.clear();
      _passwordController.clear();
    }
  });
}
```

**Why**: Provides clear feedback and prepares form for next entry.

### ✅ DO: Use Try-Catch for API Calls

```dart
void _submitForm() async {
  if (!_formKey.currentState!.validate()) return;
  
  setState(() => _isLoading = true);
  
  try {
    final response = await api.submitForm(_getFormData());
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✓ ${response.message}')),
      );
      _formKey.currentState!.reset();
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✗ Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } finally {
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}
```

**Why**: Gracefully handles errors and always cleans up loading state.

### ❌ DON'T: Process Form Without Validation

```dart
// BAD - no validation check
void _submitForm() {
  final email = _emailController.text;
  api.submit(email);  // What if email is invalid?
}

// GOOD - validate first
void _submitForm() {
  if (!_formKey.currentState!.validate()) return;  // Stop if invalid
  final email = _emailController.text;
  api.submit(email);
}
```

---

## 5. User Feedback Best Practices

### ✅ DO: Show Specific Feedback Messages

```dart
// Success feedback
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('✓ Account created successfully!'),
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 3),
  ),
);

// Error feedback
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('✗ Email already registered'),
    backgroundColor: Colors.red,
  ),
);
```

**Why**: Clear feedback improves user experience.

### ✅ DO: Use Icons/Emojis in Feedback

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Row(
      children: const [
        Icon(Icons.check_circle, color: Colors.white),
        SizedBox(width: 12),
        Text('Form submitted!'),
      ],
    ),
    backgroundColor: Colors.green,
  ),
);
```

**Why**: Icons provide additional visual context.

### ✅ DO: Set Appropriate Duration

```dart
// Short message (quick feedback)
SnackBar(
  content: Text('✓ Copied!'),
  duration: const Duration(seconds: 2),
)

// Long message (give user time to read)
SnackBar(
  content: Text('✓ Your profile has been updated successfully.'),
  duration: const Duration(seconds: 4),
)
```

**Why**: Users can read the message before it disappears.

### ❌ DON'T: Use Generic Feedback

```dart
// BAD - unclear
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Done!')),
);

// GOOD - specific
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('✓ Profile updated successfully!')),
);
```

---

## 6. Resource Management Best Practices

### ✅ DO: Always Dispose TextEditingControllers

```dart
class _MyFormScreenState extends State<MyFormScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
```

**Why**: Prevents memory leaks when widget is destroyed.

### ✅ DO: Dispose FocusNodes

```dart
class _MyFormScreenState extends State<MyFormScreen> {
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }
}
```

**Why**: Properly cleans up focus resources.

### ✅ DO: Use SingleChildScrollView for Long Forms

```dart
Scaffold(
  body: SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          // Multiple form fields
        ],
      ),
    ),
  ),
)
```

**Why**: Prevents overflow when keyboard appears.

### ❌ DON'T: Forget to Dispose Controllers

```dart
// BAD - memory leak
final controller = TextEditingController();

// GOOD - cleaned up
final controller = TextEditingController();
@override
void dispose() {
  controller.dispose();
  super.dispose();
}
```

---

## 7. Theme Integration Best Practices

### ✅ DO: Use Theme Colors

```dart
TextField(
  style: TextStyle(color: AppColors.textPrimary),
  decoration: InputDecoration(
    labelStyle: TextStyle(color: AppColors.textSecondary),
    prefixIconColor: AppColors.primary,
  ),
)
```

**Why**: Maintains design consistency across app.

### ✅ DO: Use Theme Typography

```dart
Text(
  'Create Account',
  style: AppTypography.headlineSmall,
)

ElevatedButton(
  child: Text('Submit', style: AppTypography.button),
)
```

**Why**: Consistent typography throughout app.

### ✅ DO: Respect Theme's Error Colors

```dart
TextFormField(
  decoration: InputDecoration(
    errorStyle: TextStyle(
      color: AppColors.error,  // Use theme color
    ),
  ),
)
```

**Why**: Error messages match app's design system.

---

## 8. Accessibility Best Practices

### ✅ DO: Use Meaningful Labels

```dart
TextFormField(
  decoration: InputDecoration(
    labelText: 'Email Address',  // Clear label for screen readers
    hintText: 'example@email.com',
  ),
)
```

**Why**: Screen readers can announce field purpose.

### ✅ DO: Provide Helper Text for Complex Fields

```dart
TextFormField(
  decoration: InputDecoration(
    labelText: 'Password',
    helperText: 'Min 6 characters, must include letter and number',
  ),
)
```

**Why**: Users understand requirements before attempting.

### ✅ DO: Use Appropriate Semantic HTML

```dart
Semantics(
  label: 'Login Form',
  button: true,
  enabled: true,
  child: ElevatedButton(
    onPressed: _submitForm,
    child: Text('Log In'),
  ),
)
```

**Why**: Assistive technologies understand form purpose.

---

## 9. Error Handling Best Practices

### ✅ DO: Validate All User Input

```dart
TextFormField(
  validator: (value) {
    // Check for empty
    if (value?.isEmpty ?? true) {
      return 'This field is required';
    }
    // Check for valid format
    if (value!.length < 3) {
      return 'Must be at least 3 characters';
    }
    // Additional validation
    if (!_isValidName(value)) {
      return 'Please enter a valid name';
    }
    return null;
  },
)
```

**Why**: Catches errors before sending to backend.

### ✅ DO: Show Field-Level Errors

```dart
TextFormField(
  decoration: InputDecoration(
    labelText: 'Email',
    errorText: _emailError,  // Show under field
  ),
)
```

**Why**: Users know exactly which field has error.

### ✅ DO: Clear Errors When User Fixes Input

```dart
TextFormField(
  onChanged: (value) {
    // Clear error as user types
    setState(() => _emailError = null);
  },
)
```

**Why**: Positive feedback as user fixes issues.

---

## 10. Performance Best Practices

### ✅ DO: Avoid Rebuilding Entire Form

```dart
// BAD - rebuilds whole form
setState(() => _loading = true);

// GOOD - only rebuild loading button if possible
// Use separate StatefulWidget for button
```

**Why**: Improves performance with large forms.

### ✅ DO: Use Const Widgets

```dart
TextFormField(
  decoration: const InputDecoration(
    labelText: 'Email',
    prefixIcon: Icon(Icons.email),  // Not const
  ),
)

// vs

TextFormField(
  decoration: InputDecoration(
    labelText: 'Email',
    prefixIcon: const Icon(Icons.email),  // Const icon
  ),
)
```

**Why**: Prevents unnecessary rebuilds.

### ✅ DO: Debounce Network Requests on onChange

```dart
Timer? _debounce;

void _onEmailChanged(String value) {
  _debounce?.cancel();
  _debounce = Timer(const Duration(milliseconds: 500), () {
    // Check if email exists (API call)
    _checkEmailAvailable(value);
  });
}

@override
void dispose() {
  _debounce?.cancel();
  super.dispose();
}
```

**Why**: Reduces server load and improves UX.

---

## Summary Checklist

- [ ] Form uses StatefulWidget
- [ ] GlobalKey<FormState> created and assigned
- [ ] All TextEditingControllers disposed
- [ ] Validators provide specific error messages
- [ ] Form validation checked before submission
- [ ] Loading state shown during async operations
- [ ] mounted checked before setState in callbacks
- [ ] Success feedback shown with SnackBar
- [ ] Form reset after successful submission
- [ ] Theme colors and typography used
- [ ] Keyboard type matches input type
- [ ] Labels and hints provided for all fields
- [ ] SingleChildScrollView used for long forms
- [ ] Icons/visual cues added for context
- [ ] Error messages display below fields

---

Last updated: Sprint 6
Reference: Flutter Form Best Practices
