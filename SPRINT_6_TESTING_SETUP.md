# Sprint 6: Testing & Setup Instructions

## 🚀 Quick Start

### Prerequisites
- Flutter SDK installed and in PATH
- VS Code with Flutter extension
- Project repository cloned
- `flutter pub get` already run

### Enable Demo Mode

To test all the new form examples, set demo mode to `true` in `main.dart`:

```dart
// lib/main.dart - Line ~40
const bool isDemoMode = true;  // Change to true
```

### Run the App

```bash
cd d:\instagram\instagram
flutter run
```

### Access User Input Forms

1. App launches in demo mode showing "Flutter Learning Demos"
2. Scroll down to find "User Input Forms" card
3. Tap the card to enter the form hub
4. Choose any form to test (Sign Up, Login, Feedback, Profile)

---

## 📱 Testing Each Form

### Sign Up Form

**Location**: User Input Forms > Sign Up Form

**Test Cases**:

1. **Empty Fields**
   - Leave all fields empty
   - Tap "Create Account"
   - Expected: See "Please enter your name" error

2. **Invalid Email**
   - Name: "John Doe"
   - Email: "invalid" (missing @ and .)
   - Tap "Create Account"
   - Expected: See email validation error

3. **Password Mismatch**
   - Name: "John Doe"
   - Email: "john@example.com"
   - Password: "Password123"
   - Confirm: "Password456"
   - Expected: See "Passwords do not match" error

4. **Valid Submission**
   - Fill all fields correctly:
     - Name: "John Doe" (or any name >= 3 chars)
     - Email: "john@example.com"
     - Password: "password123" (or any >= 6 chars)
     - Confirm: Match the password
   - Tap "Create Account"
   - Expected: 
     - Loading spinner appears
     - After 2 seconds: Success SnackBar appears
     - Form clears all fields

### Login Form

**Location**: User Input Forms > Login Form

**Test Cases**:

1. **Empty Email**
   - Leave email empty
   - Enter password: "password123"
   - Tap "Sign In"
   - Expected: See "Please enter your email" error

2. **Invalid Email Format**
   - Email: "notanemail"
   - Password: "password123"
   - Tap "Sign In"
   - Expected: See email validation error

3. **Short Password**
   - Email: "test@example.com"
   - Password: "pass" (less than 6 chars)
   - Tap "Sign In"
   - Expected: See password length error

4. **Password Visibility Toggle**
   - Enter any password
   - Tap the eye icon next to password field
   - Expected: Password text becomes visible
   - Tap again: Password becomes obscured

5. **Valid Submission**
   - Email: "test@example.com"
   - Password: "password123"
   - Tap "Sign In"
   - Expected: Success SnackBar appears with checkmark

6. **Remember Me Checkbox**
   - Tap "Remember me" checkbox
   - Expected: Checkbox becomes checked/unchecked

7. **Sign Up Link**
   - Tap "Sign Up" link at bottom
   - Expected: Navigate back to form hub

### Feedback Form

**Location**: User Input Forms > Feedback Form

**Test Cases**:

1. **Required Fields**
   - Leave name or email empty
   - Tap "Submit Feedback"
   - Expected: See validation errors

2. **Star Rating Selection**
   - Tap different stars (1-5)
   - Expected: Selected star and all below turn yellow
   - Unselected stars turn gray

3. **Feedback Length Validation**
   - Name: "John Doe"
   - Email: "john@example.com"
   - Feedback: "bad" (less than 10 chars)
   - Tap "Submit Feedback"
   - Expected: See length error under feedback field

4. **Valid Submission**
   - Name: "John Doe"
   - Email: "john@example.com"
   - Select 5 stars (or any rating)
   - Feedback: "This is great feedback for the app"
   - Tap "Submit Feedback"
   - Expected: Success SnackBar appears

5. **Form Reset**
   - After successful submission
   - Expected: All fields clear, rating resets to 5 stars

### Profile Form

**Location**: User Input Forms > Profile Form

**Test Cases**:

1. **Required Fields**
   - Leave first or last name empty
   - Tap "Save Changes"
   - Expected: See validation errors

2. **Gender Dropdown**
   - Tap gender dropdown
   - Select "Female" or "Other"
   - Expected: Dropdown shows selection

3. **Phone Validation (Optional)**
   - Leave phone empty: Should pass validation
   - Enter phone: "12345" (less than 10 chars)
   - Tap "Save Changes"
   - Expected: See validation error
   - Enter phone: "1234567890" (exactly 10)
   - Should pass validation

4. **Bio Character Limit**
   - Enter bio with > 200 characters
   - Tap "Save Changes"
   - Expected: See "Must be less than 200 characters" error

5. **Valid Submission**
   - First Name: "John"
   - Last Name: "Doe"
   - Gender: "Male"
   - Phone: "1234567890" (or leave empty)
   - Bio: "I am a Flutter developer" (or leave empty)
   - Tap "Save Changes"
   - Expected: Success SnackBar appears

---

## 🔍 Code Exploration Guide

### File Structure
```
lib/
├── screens/
│   └── user_input_form_screen.dart (650+ lines)
│       ├── UserInputFormHub (lines 1-80)
│       ├── SignUpFormScreen (lines 150-350)
│       ├── LoginFormScreen (lines 380-550)
│       ├── FeedbackFormScreen (lines 580-750)
│       └── ProfileFormScreen (lines 780-950)
└── main.dart (updated with new import and demo card)
```

### Key Code Sections to Review

**1. Form Validation Pattern** (lines 180-200 in SignUpFormScreen)
```dart
TextFormField(
  controller: _emailController,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Please enter a valid email address';
    }
    return null;
  },
)
```

**2. Form Submission with Loading** (lines 120-160 in SignUpFormScreen)
```dart
void _submitForm() {
  if (_formKey.currentState!.validate()) {
    setState(() => _isLoading = true);
    
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(...)
        _formKey.currentState!.reset();
      }
    });
  }
}
```

**3. Interactive Star Rating** (lines 600-620 in FeedbackFormScreen)
```dart
Row(
  children: List.generate(5, (index) {
    int rating = index + 1;
    bool isSelected = int.parse(_selectedRating) == rating;
    return GestureDetector(
      onTap: () => setState(() => _selectedRating = '$rating'),
      child: Icon(
        Icons.star,
        size: 40,
        color: isSelected ? AppColors.warning : AppColors.borderLight,
      ),
    );
  }),
)
```

---

## 📚 Documentation Files

| File | Purpose | Size |
|------|---------|------|
| SPRINT_6_USER_INPUT_FORMS.md | Comprehensive technical guide | 700+ lines |
| FORM_VALIDATION_QUICK_REFERENCE.md | Quick reference and snippets | 400+ lines |
| SPRINT_6_BEST_PRACTICES_GUIDE.md | DO/DON'T best practices | 500+ lines |
| SPRINT_6_COMPLETION_SUMMARY.md | Sprint overview and metrics | 700+ lines |

**Total Documentation**: 2,300+ lines

### How to Use Documentation

1. **Start with**: SPRINT_6_COMPLETION_SUMMARY.md for overview
2. **Deep dive**: SPRINT_6_USER_INPUT_FORMS.md for implementation details
3. **Quick lookup**: FORM_VALIDATION_QUICK_REFERENCE.md for code snippets
4. **Best practices**: SPRINT_6_BEST_PRACTICES_GUIDE.md for guidelines

---

## 🎯 Learning Checklist

After testing, verify you understand:

### Form Fundamentals
- [ ] What GlobalKey<FormState> does
- [ ] How Form widget contains fields
- [ ] How validation works in TextFormField
- [ ] What validators return (null vs error string)

### Validation
- [ ] How to write custom validators
- [ ] How to validate multiple conditions
- [ ] How to show field-specific errors
- [ ] How to handle optional fields

### User Feedback
- [ ] How to use ScaffoldMessenger.showSnackBar()
- [ ] How to show loading states
- [ ] How to reset forms after submission
- [ ] How to handle async operations

### State Management
- [ ] When to use TextEditingController
- [ ] How to dispose controllers properly
- [ ] When to check mounted before setState
- [ ] How to manage boolean state (loading, visibility)

### Theme Integration
- [ ] How to apply AppColors to forms
- [ ] How to apply AppTypography to text
- [ ] How to style InputDecoration
- [ ] How to maintain design consistency

---

## 🐛 Troubleshooting

### Form Validation Not Working
**Issue**: Validators not triggering
**Solution**: Ensure TextFormField is inside Form widget with GlobalKey

```dart
Form(
  key: _formKey,  // Make sure this exists
  child: TextFormField(
    validator: ...,  // This will work now
  ),
)
```

### setState Called After Dispose
**Issue**: "setState called after dispose" error
**Solution**: Check mounted before calling setState

```dart
Future.delayed(duration, () {
  if (mounted) {  // Add this check
    setState(() => _isLoading = false);
  }
});
```

### Memory Leak Warning
**Issue**: "Memory leak: Controller not disposed"
**Solution**: Dispose controllers in dispose()

```dart
@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();
}
```

### Form Fields Not Resetting
**Issue**: Form doesn't clear after submission
**Solution**: Call reset() on form state

```dart
_formKey.currentState!.reset();  // Clears all fields
```

---

## 🧪 Advanced Testing

### Test Custom Validators
Edit FORM_VALIDATION_QUICK_REFERENCE.md and try:

```dart
String? validateEmail(String? value) {
  if (value?.isEmpty ?? true) return 'Email required';
  if (!value!.contains('@') || !value.contains('.')) {
    return 'Invalid email format';
  }
  return null;
}
```

### Test Form Reset
After submission, verify:
- [ ] All TextFormFields clear
- [ ] Focus returns to first field
- [ ] Error messages disappear
- [ ] Loading state resets

### Test Error Messages
Intentionally enter invalid data to verify:
- [ ] Error appears under correct field
- [ ] Error text is red (error color)
- [ ] Error clears when user fixes input
- [ ] Multiple errors show independently

---

## 📊 Files to Examine

### Implementation
- [user_input_form_screen.dart](lib/screens/user_input_form_screen.dart) - 650+ lines

### Main App Integration
- [main.dart](lib/main.dart) - Look for "User Input Forms" card

### Theme Integration
- [app_colors.dart](lib/theme/app_colors.dart) - Colors used in forms
- [app_typography.dart](lib/theme/app_typography.dart) - Text styles used

---

## ✅ Testing Completion Checklist

- [ ] Ran app in demo mode
- [ ] Accessed User Input Forms hub
- [ ] Tested Sign Up form (empty, invalid, valid)
- [ ] Tested Login form (validation, toggle password, submit)
- [ ] Tested Feedback form (stars, validation, submit)
- [ ] Tested Profile form (dropdown, optional fields, submit)
- [ ] Verified SnackBar feedback appears
- [ ] Verified loading spinner shows
- [ ] Verified forms reset after submission
- [ ] Read SPRINT_6_USER_INPUT_FORMS.md (all sections)
- [ ] Reviewed code snippets in FORM_VALIDATION_QUICK_REFERENCE.md
- [ ] Studied best practices in SPRINT_6_BEST_PRACTICES_GUIDE.md
- [ ] Understood GlobalKey<FormState> pattern
- [ ] Understood validator return values
- [ ] Understood form submission flow
- [ ] Explored theme integration

---

## 🎓 Next Learning Steps

After mastering this sprint, explore:

1. **Advanced Validation**
   - Regex patterns for complex validation
   - Cross-field validation (dependency between fields)
   - Async validation (email availability check)

2. **Complex Forms**
   - Multi-step form wizard
   - Form field dependencies
   - Conditional validation

3. **State Management**
   - Form state persistence
   - Save/restore form data
   - Integration with Provider or GetX

4. **Advanced UI**
   - Date/time picker fields
   - File upload fields
   - Image picker integration

---

## 📞 Support

If you encounter issues:

1. Check the troubleshooting section above
2. Review the relevant documentation guide
3. Examine code examples in FORM_VALIDATION_QUICK_REFERENCE.md
4. Check best practices in SPRINT_6_BEST_PRACTICES_GUIDE.md

---

**Sprint 6 Setup Complete!**
Ready to test and learn form handling in Flutter.

Last updated: Sprint 6
