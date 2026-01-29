# Form Validation Quick Reference

## Common Validators

### Email Validator
```dart
String? validateEmail(String? value) {
  if (value?.isEmpty ?? true) return 'Email required';
  if (!value!.contains('@') || !value.contains('.')) {
    return 'Invalid email format';
  }
  return null;
}
```

### Password Validator
```dart
String? validatePassword(String? value) {
  if (value?.isEmpty ?? true) return 'Password required';
  if (value!.length < 6) return 'Min 6 characters';
  return null;
}
```

### Phone Validator
```dart
String? validatePhone(String? value) {
  if (value?.isEmpty ?? true) return 'Phone required';
  if (value!.length < 10) return 'Invalid phone';
  if (!RegExp(r'^\d+$').hasMatch(value)) {
    return 'Phone must be digits only';
  }
  return null;
}
```

### URL Validator
```dart
String? validateUrl(String? value) {
  if (value?.isEmpty ?? true) return 'URL required';
  final urlRegex = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$'
  );
  if (!urlRegex.hasMatch(value!)) return 'Invalid URL';
  return null;
}
```

---

## Form Structure Template

```dart
class MyFormScreen extends StatefulWidget {
  @override
  State<MyFormScreen> createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    // API call here
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Success!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Quick Tips

### 1. Always Dispose Controllers
```dart
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

### 2. Check Mounted Before SetState
```dart
Future.delayed(duration, () {
  if (mounted) {
    setState(() => _loading = false);
  }
});
```

### 3. Validate Before Processing
```dart
if (_formKey.currentState!.validate()) {
  // Process form
}
```

### 4. Reset After Success
```dart
ScaffoldMessenger.of(context).showSnackBar(...);
_formKey.currentState!.reset();
```

### 5. Show Password Toggle
```dart
TextFormField(
  obscureText: !_showPassword,
  suffixIcon: IconButton(
    icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
    onPressed: () => setState(() => _showPassword = !_showPassword),
  ),
)
```

---

## Input Decorations

### Basic
```dart
InputDecoration(labelText: 'Email')
```

### With Icons
```dart
InputDecoration(
  labelText: 'Email',
  prefixIcon: Icon(Icons.email),
  suffixIcon: Icon(Icons.check),
)
```

### With Hints
```dart
InputDecoration(
  labelText: 'Password',
  hintText: 'Min 6 characters',
  helperText: 'Use letters and numbers',
)
```

### Validation Styling
```dart
InputDecoration(
  labelText: 'Email',
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
  ),
)
```

---

## SnackBar Examples

### Success
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('✓ Success!'),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 3),
  ),
);
```

### Error
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('✗ Error occurred'),
    backgroundColor: Colors.red,
  ),
);
```

### With Action
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Item deleted'),
    action: SnackBarAction(
      label: 'UNDO',
      onPressed: () { /* undo */ },
    ),
  ),
);
```

---

## Form Field Types

### Text Field
```dart
TextFormField(
  decoration: InputDecoration(labelText: 'Name'),
  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
)
```

### Email Field
```dart
TextFormField(
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(labelText: 'Email'),
  validator: validateEmail,
)
```

### Password Field
```dart
TextFormField(
  obscureText: true,
  decoration: InputDecoration(labelText: 'Password'),
  validator: validatePassword,
)
```

### Phone Field
```dart
TextFormField(
  keyboardType: TextInputType.phone,
  decoration: InputDecoration(labelText: 'Phone'),
  validator: validatePhone,
)
```

### Number Field
```dart
TextFormField(
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'Age'),
  validator: (v) {
    if (v?.isEmpty ?? true) return 'Required';
    if (int.tryParse(v!) == null) return 'Invalid number';
    return null;
  },
)
```

### Multiline Field
```dart
TextFormField(
  maxLines: 4,
  decoration: InputDecoration(
    labelText: 'Comments',
    alignLabelWithHint: true,
  ),
)
```

### Dropdown Field
```dart
DropdownButtonFormField<String>(
  value: _selected,
  items: ['Option 1', 'Option 2']
    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
    .toList(),
  onChanged: (v) => setState(() => _selected = v),
)
```

### Checkbox Field
```dart
CheckboxListTile(
  value: _agreed,
  onChanged: (v) => setState(() => _agreed = v ?? false),
  title: Text('I agree to terms'),
)
```

---

## Complex Validators

### Password Match
```dart
String? validateMatch(String? value, String other) {
  if (value != other) return 'Passwords do not match';
  return null;
}
```

### Minimum Length
```dart
String? validateMinLength(String? value, int min) {
  if (value?.isEmpty ?? true) return 'Required';
  if (value!.length < min) return 'Min $min characters';
  return null;
}
```

### Regular Expression
```dart
String? validatePattern(String? value, String pattern) {
  if (value?.isEmpty ?? true) return 'Required';
  if (!RegExp(pattern).hasMatch(value!)) return 'Invalid format';
  return null;
}
```

### Age Range
```dart
String? validateAge(String? value, int min, int max) {
  if (value?.isEmpty ?? true) return 'Required';
  final age = int.tryParse(value!);
  if (age == null || age < min || age > max) {
    return 'Age must be between $min and $max';
  }
  return null;
}
```

---

## State Management Pattern

```dart
// Loading state
bool _isLoading = false;

// Async submission
void _submit() async {
  if (!_formKey.currentState!.validate()) return;
  
  setState(() => _isLoading = true);
  
  try {
    final response = await apiCall();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Success!')),
      );
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
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

// In button
ElevatedButton(
  onPressed: _isLoading ? null : _submit,
  child: _isLoading
    ? SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      )
    : Text('Submit'),
)
```

---

## Common Pitfalls to Avoid

❌ **Don't** forget to dispose controllers
```dart
// BAD
final controller = TextEditingController();

// GOOD
final controller = TextEditingController();
@override
void dispose() {
  controller.dispose();
  super.dispose();
}
```

❌ **Don't** forget the Form widget wrapper
```dart
// BAD - validator won't work without Form
TextFormField(validator: (v) => ...)

// GOOD
Form(
  key: _formKey,
  child: TextFormField(validator: (v) => ...),
)
```

❌ **Don't** forget to check mounted
```dart
// BAD - could crash if widget is unmounted
setState(() => _isLoading = false);

// GOOD
if (mounted) {
  setState(() => _isLoading = false);
}
```

❌ **Don't** forget to reset on success
```dart
// BAD - form stays filled after success
ScaffoldMessenger.of(context).showSnackBar(...);

// GOOD
ScaffoldMessenger.of(context).showSnackBar(...);
_formKey.currentState!.reset();
```

❌ **Don't** return strings for valid fields
```dart
// BAD - validator returns message for valid field
validator: (v) => v?.isEmpty ?? true ? 'Required' : 'Valid',

// GOOD - return null for valid
validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
```

---

## Testing Forms

### Unit Test Example
```dart
testWidgets('Form validation works', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  
  // Leave field empty and tap submit
  await tester.tap(find.byType(ElevatedButton));
  await tester.pumpAndSettle();
  
  // Verify error message
  expect(find.text('Required'), findsOneWidget);
});
```

---

Last updated: Sprint 6
