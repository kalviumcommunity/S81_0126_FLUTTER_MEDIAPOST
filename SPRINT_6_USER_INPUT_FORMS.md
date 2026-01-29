# Sprint 6: User Input Forms & Validation System

## Overview

Sprint 6 implements a comprehensive user input form handling system with validation, error handling, and visual feedback patterns. This sprint demonstrates professional form design using Flutter's Form widget, TextFormField, and integrated theme system.

**Implementation Time**: Complete form system with 4 different form examples
**Lines of Code**: 650+ lines of production code
**Documentation**: This guide + inline code comments

---

## Key Objectives

1. ✅ Master Form widget and form state management
2. ✅ Implement TextFormField with custom validators
3. ✅ Build multiple real-world form examples
4. ✅ Create visual feedback with SnackBar
5. ✅ Integrate with professional theme system
6. ✅ Implement proper error handling and display

---

## What You'll Learn

### 1. Form State Management
- Using `GlobalKey<FormState>` to access form validation state
- `Form` widget as container for validated fields
- Form reset and field clearing patterns

### 2. TextFormField Validation
- Built-in validators (email, required, length)
- Custom validator functions
- Display error messages to users
- Real-time validation feedback

### 3. User Feedback Mechanisms
- ScaffoldMessenger and SnackBar notifications
- Success and error feedback patterns
- Loading state management (async operations)
- Form reset after submission

### 4. Input Handling Patterns
- TextEditingController for field value access
- Focus management with FocusNode
- Show/hide password toggle
- Multiline text fields
- Dropdown selection fields
- Checkbox state management

### 5. Theme Integration
- Using AppColors in form styling
- Using AppTypography for consistent text
- InputDecoration with theme colors
- Responsive form layouts

---

## Architecture

### File Structure
```
lib/
├── screens/
│   └── user_input_form_screen.dart (650+ lines)
│       ├── UserInputFormHub (Main navigation hub)
│       ├── SignUpFormScreen (Email, password validation)
│       ├── LoginFormScreen (Email & password with remember me)
│       ├── FeedbackFormScreen (Multi-field with rating)
│       └── ProfileFormScreen (Comprehensive user profile)
└── main.dart (Updated with new demo card)
```

### Component Structure

```
UserInputFormHub
├── _FormCard (Reusable form entry card)
├── SignUpFormScreen
│   ├── Form (GlobalKey<FormState>)
│   ├── TextFormField (Name, Email, Password)
│   ├── ElevatedButton (Submit)
│   └── SnackBar (Success feedback)
├── LoginFormScreen
│   ├── Form
│   ├── TextFormField (Email, Password)
│   ├── Checkbox (Remember me)
│   └── SnackBar
├── FeedbackFormScreen
│   ├── Form
│   ├── TextFormField (Name, Email, Feedback)
│   ├── Rating Stars (Interactive selection)
│   └── SnackBar
└── ProfileFormScreen
    ├── Form
    ├── TextFormField (Name, Bio, Phone)
    ├── DropdownButtonFormField (Gender)
    └── SnackBar
```

---

## Code Patterns & Examples

### 1. Basic Form Structure

```dart
class MyFormScreen extends StatefulWidget {
  const MyFormScreen({Key? key}) : super(key: key);

  @override
  State<MyFormScreen> createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Form fields here
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Form is valid, proceed
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 2. TextFormField with Validation

```dart
TextFormField(
  controller: _emailController,
  decoration: InputDecoration(
    labelText: 'Email Address',
    hintText: 'example@email.com',
    prefixIcon: const Icon(Icons.email),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.error),
    ),
  ),
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Please enter a valid email address';
    }
    return null; // Return null if valid
  },
)
```

### 3. Custom Validator Function

```dart
String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  
  final emailRegex = RegExp(
    r'^[^@]+@[^@]+\.[^@]+$'
  );
  
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  
  return null;
}

// Usage:
TextFormField(
  validator: _validateEmail,
)
```

### 4. SnackBar Feedback

```dart
void _submitForm() {
  if (_formKey.currentState!.validate()) {
    // Show loading
    setState(() => _isLoading = true);

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✓ Form submitted successfully!'),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 3),
          ),
        );

        // Reset form
        _formKey.currentState!.reset();
      }
    });
  }
}
```

### 5. Show/Hide Password Toggle

```dart
bool _showPassword = false;

TextFormField(
  controller: _passwordController,
  obscureText: !_showPassword,
  decoration: InputDecoration(
    labelText: 'Password',
    prefixIcon: const Icon(Icons.lock),
    suffixIcon: IconButton(
      icon: Icon(
        _showPassword ? Icons.visibility : Icons.visibility_off,
      ),
      onPressed: () {
        setState(() => _showPassword = !_showPassword);
      },
    ),
  ),
)
```

### 6. Dropdown Selection Field

```dart
String _selectedGender = 'Male';

DropdownButtonFormField<String>(
  value: _selectedGender,
  decoration: InputDecoration(
    labelText: 'Gender',
    prefixIcon: const Icon(Icons.wc),
  ),
  items: ['Male', 'Female', 'Other', 'Not specified']
      .map((gender) => DropdownMenuItem(
            value: gender,
            child: Text(gender),
          ))
      .toList(),
  onChanged: (value) {
    setState(() => _selectedGender = value ?? 'Male');
  },
)
```

### 7. Interactive Rating Stars

```dart
String _selectedRating = '5';

Row(
  children: List.generate(5, (index) {
    int rating = index + 1;
    bool isSelected = int.parse(_selectedRating) == rating;
    return GestureDetector(
      onTap: () => setState(() => _selectedRating = '$rating'),
      child: Icon(
        Icons.star,
        size: 40,
        color: isSelected ? AppColors.warning : Colors.grey,
      ),
    );
  }),
)
```

### 8. Multiline TextField

```dart
TextFormField(
  decoration: InputDecoration(
    labelText: 'Your Feedback',
    hintText: 'Tell us what you think...',
    prefixIcon: const Icon(Icons.message),
    alignLabelWithHint: true,
  ),
  maxLines: 4,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter feedback';
    }
    if (value.length < 10) {
      return 'Feedback must be at least 10 characters';
    }
    return null;
  },
)
```

---

## Form Examples Breakdown

### 1. Sign Up Form

**Purpose**: Registration with full validation

**Fields**:
- Full Name (required, min 3 chars)
- Email (required, valid format)
- Password (required, min 6 chars)
- Confirm Password (required, must match)

**Features**:
- Password visibility toggle
- Password match validation
- Loading state during submission
- Success feedback with SnackBar
- Form reset after successful submission

**Validation Pattern**:
```dart
- Name: required, length >= 3
- Email: required, contains @ and .
- Password: required, length >= 6
- Confirm: required, matches password
```

### 2. Login Form

**Purpose**: User authentication

**Fields**:
- Email (required, valid format)
- Password (required, min 6 chars)
- Remember Me (checkbox)

**Features**:
- Minimal, focused form design
- Password visibility toggle
- Remember me option
- Loading state on submit
- Success feedback
- Sign up link reference

**Validation Pattern**:
```dart
- Email: required, contains @
- Password: required, length >= 6
```

### 3. Feedback Form

**Purpose**: User feedback collection with ratings

**Fields**:
- Name (required)
- Email (required, valid format)
- Experience Rating (1-5 stars, interactive)
- Feedback Text (required, min 10 chars)

**Features**:
- Interactive star rating selector
- Dynamic selection feedback
- Multiline text field for feedback
- Field validation with helpful messages
- Success notification with emoji

**Validation Pattern**:
```dart
- Name: required
- Email: required, valid format
- Feedback: required, length >= 10
```

### 4. Profile Form

**Purpose**: User profile management

**Fields**:
- First Name (required)
- Last Name (required)
- Gender (dropdown selector)
- Phone Number (optional, length validation)
- Bio (optional, max 200 chars)

**Features**:
- Dropdown selection
- Optional fields with graceful validation
- Bio character limit enforcement
- Phone number validation
- Save profile feedback

**Validation Pattern**:
```dart
- First/Last Name: required
- Phone: optional, if provided min 10 chars
- Bio: optional, max 200 chars
```

---

## Theme Integration

### Colors Used

All forms use the theme system colors for consistent styling:

```dart
AppColors.primary        // Form titles, focus colors
AppColors.secondary      // Accent elements
AppColors.surface        // AppBar background
AppColors.error          // Error message color
AppColors.success        // Success feedback color
AppColors.warning        // Star ratings, highlights
AppColors.textPrimary    // Field labels
AppColors.textSecondary  // Helper text
AppColors.borderLight    // Input borders
```

### Typography Used

```dart
AppTypography.headlineSmall      // Form page titles
AppTypography.titleMedium        // Field section headers
AppTypography.bodyMedium         // Body text, SnackBar
AppTypography.bodySmall          // Helper text, descriptions
AppTypography.button             // Button text (bold)
```

### InputDecoration Pattern

```dart
InputDecoration(
  labelText: 'Field Label',
  hintText: 'Placeholder text',
  prefixIcon: const Icon(Icons.person),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  // Error styling handled by Material theme
)
```

---

## Common Validation Patterns

### Email Validation
```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  }
  if (!value.contains('@') || !value.contains('.')) {
    return 'Please enter a valid email';
  }
  return null;
}
```

### Phone Number Validation
```dart
validator: (value) {
  if (value != null && value.isNotEmpty) {
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
  }
  return null; // Optional field
}
```

### Password Strength Validation
```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain a number';
  }
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain an uppercase letter';
  }
  return null;
}
```

### Password Match Validation
```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }
  if (value != _passwordController.text) {
    return 'Passwords do not match';
  }
  return null;
}
```

### Required Field with Length
```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  if (value.length < 10) {
    return 'Must be at least 10 characters';
  }
  if (value.length > 200) {
    return 'Must be less than 200 characters';
  }
  return null;
}
```

---

## Best Practices Implemented

### 1. Resource Management
- ✅ Dispose controllers in `dispose()` method
- ✅ Check `mounted` before setState in async operations
- ✅ Clear form state after successful submission

### 2. User Experience
- ✅ Clear, specific error messages
- ✅ Field hints and helper text
- ✅ Visual feedback (loading spinner, SnackBar)
- ✅ Password visibility toggle
- ✅ Form reset after success
- ✅ Icon prefix for field context

### 3. Accessibility
- ✅ Proper labelText for screen readers
- ✅ Meaningful error messages
- ✅ Icon context clues
- ✅ Readable contrast in typography

### 4. Code Organization
- ✅ Separate StatefulWidget for form state
- ✅ Reusable _FormCard component
- ✅ Clear method names (_submitForm, _validateEmail)
- ✅ Logical field grouping in UI

### 5. Security Patterns
- ✅ Password field obscuring
- ✅ Show/hide password toggle
- ✅ No sensitive data logging
- ✅ Input validation on client

---

## Testing the Forms

### Access in Demo Mode

1. Set `isDemoMode = true` in `main.dart`
2. Tap "User Input Forms" card in demo home
3. Choose a form to test (Sign Up, Login, Feedback, Profile)
4. Fill fields and observe validation behavior
5. Submit successful form to see success feedback
6. Try invalid inputs to see error messages

### Test Scenarios

**Sign Up Form**:
- [ ] Leave fields empty → See required messages
- [ ] Enter short name (1 char) → See length error
- [ ] Enter invalid email → See format error
- [ ] Enter mismatched passwords → See match error
- [ ] Fill all valid → See success SnackBar

**Login Form**:
- [ ] Empty email → See required message
- [ ] Invalid email format → See format error
- [ ] Password too short → See length error
- [ ] Toggle password visibility → See text toggle
- [ ] Check remember me → See checkbox state
- [ ] Valid form → See success message

**Feedback Form**:
- [ ] Click different star ratings → See color change
- [ ] Leave feedback empty → See required message
- [ ] Enter short feedback (< 10 chars) → See length error
- [ ] Fill all fields → See success message

**Profile Form**:
- [ ] Select different gender → See dropdown update
- [ ] Enter invalid phone → See validation error
- [ ] Enter long bio (> 200 chars) → See length error
- [ ] Leave optional fields empty → Should pass validation
- [ ] Fill valid form → See success message

---

## Integration with Theme System

### Colors Applied
- Form titles use `AppTypography.headlineSmall`
- Labels use `AppTypography.titleMedium`
- Error messages use `AppColors.error`
- Success feedback uses `AppColors.success`
- Buttons use theme's ElevatedButton style

### Consistency Across Forms
- All forms use same input styling
- Same error message color (red)
- Same success feedback color (green)
- Consistent spacing and padding
- Unified icon usage

---

## Files Modified/Created

### New Files
- `lib/screens/user_input_form_screen.dart` (650+ lines)
  - UserInputFormHub
  - SignUpFormScreen
  - LoginFormScreen
  - FeedbackFormScreen
  - ProfileFormScreen

### Updated Files
- `lib/main.dart`
  - Added import for user_input_form_screen
  - Added "User Input Forms" demo card

---

## Key Takeaways

1. **Form Widget** manages validation state across multiple fields
2. **TextFormField** provides validator property for field-level validation
3. **GlobalKey<FormState>** allows access to form methods (.validate(), .reset())
4. **TextEditingController** manages field values and cleanup
5. **ScaffoldMessenger.showSnackBar()** provides user feedback
6. **Theme integration** keeps forms consistent with app design
7. **Error messages** should be specific and helpful
8. **Async handling** requires mounted check before setState

---

## Next Steps (Sprint 7)

- [ ] Add complex validation patterns (regex, custom rules)
- [ ] Implement form field dependencies (conditional validation)
- [ ] Add password strength indicator visualization
- [ ] Implement file upload fields
- [ ] Create form builder pattern for reusable forms
- [ ] Add date/time picker fields
- [ ] Implement form persistence (save/restore state)

---

## Resources & References

- Flutter Form Widget: https://api.flutter.dev/flutter/widgets/Form-class.html
- TextFormField: https://api.flutter.dev/flutter/material/TextFormField-class.html
- Form Validation Guide: https://flutter.dev/docs/cookbook/forms/validation

---

**Sprint Status**: ✅ Complete - Ready for Sprint 7
**Last Updated**: [Today's Date]
**Contributor**: Flutter Learning System
