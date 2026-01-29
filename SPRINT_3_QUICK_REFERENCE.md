# Responsive Layout Design - Quick Reference

## 🎯 Quick Start

### Core Widgets

#### Container
Flexible box for styling and layout:
```dart
Container(
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.all(8),
  color: Colors.blue,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
  child: Text('Content'),
)
```

#### Row
Arrange children horizontally:
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [Widget1(), Widget2(), Widget3()],
)
```

#### Column
Arrange children vertically:
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [Widget1(), Widget2(), Widget3()],
)
```

---

## 📱 MediaQuery Essentials

```dart
// Get device info
final width = MediaQuery.of(context).size.width;
final height = MediaQuery.of(context).size.height;
final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

// Responsive logic
if (width < 600) {
  // Phone layout
} else if (width < 900) {
  // Tablet layout
} else {
  // Desktop layout
}
```

---

## 🔄 Alignment Quick Reference

### MainAxisAlignment (Row: horizontal, Column: vertical)
| Value | Effect |
|-------|--------|
| `start` | Items at beginning |
| `center` | Items centered |
| `end` | Items at end |
| `spaceBetween` | Space between items |
| `spaceAround` | Space around items |
| `spaceEvenly` | Equal space everywhere |

### CrossAxisAlignment (Row: vertical, Column: horizontal)
| Value | Effect |
|-------|--------|
| `start` | Align to top/left |
| `center` | Center |
| `end` | Align to bottom/right |
| `stretch` | Fill available space |

---

## 🎨 Common Patterns

### Responsive Card
```dart
Container(
  width: screenWidth > 600 ? 400 : double.infinity,
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3))],
  ),
  child: Column(children: [...]),
)
```

### Responsive Grid
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: screenWidth > 900 ? 3 : screenWidth > 600 ? 2 : 1,
    mainAxisSpacing: 16,
    crossAxisSpacing: 16,
  ),
  itemBuilder: (context, index) => Card(...),
)
```

### Responsive Row/Column
```dart
screenWidth > 600
    ? Row(
        children: [
          Expanded(child: Widget1()),
          Expanded(child: Widget2()),
        ],
      )
    : Column(
        children: [
          Widget1(),
          Widget2(),
        ],
      )
```

---

## 📐 Layout Sizes

### Common Breakpoints
```
Phone:     < 600px
Tablet:    600px - 900px
Desktop:   > 900px
```

### Common Widths
- Pixel 4/5:    412px × 915px
- Pixel 6:      412px × 915px
- Pixel XL:     1080px × 1920px
- iPad:         1024px × 1366px
- iPad Pro:     1366px × 1024px

---

## ⚡ Performance Tips

### ✅ Do's
- Use `const` constructors
- Use `Expanded` for flexible sizing
- Cache `MediaQuery` values
- Use `SingleChildScrollView` for overflow

### ❌ Don'ts
- Don't nest too many Rows/Columns
- Don't hardcode dimensions
- Don't rebuild entire widget tree on size change
- Don't ignore safe areas

---

## 🧪 Testing Checklist

```
Device Types:
  ☐ Small phone (< 600px)
  ☐ Tablet (600-900px)
  ☐ Large screen (> 900px)

Orientations:
  ☐ Portrait
  ☐ Landscape

Visual:
  ☐ No overflow
  ☐ Text readable
  ☐ Images scale
  ☐ Buttons accessible
  ☐ Proper spacing
```

---

## 💡 Key Concepts

| Concept | Purpose |
|---------|---------|
| Container | Styling and layout wrapper |
| Row | Horizontal child arrangement |
| Column | Vertical child arrangement |
| Expanded | Fill available space (flex) |
| Flexible | Flexible sizing with constraints |
| MediaQuery | Detect device information |
| SafeArea | Respect notches/status bars |
| SizedBox | Fixed spacing |
| AspectRatio | Maintain width:height ratio |

---

## 🎯 Decision Tree

```
Need to arrange items?
  ├─ Horizontally? → Row
  └─ Vertically? → Column

Need to style/pad?
  └─ Use Container

Need responsive behavior?
  ├─ Different layout per size? → MediaQuery + if/else
  └─ Same layout, different sizing? → Expanded/Flexible

Need to prevent overflow?
  └─ Use SingleChildScrollView or ListView
```

---

## 📚 Implementation Summary

This sprint covers:
- **Container**: Styling, padding, margins, sizing
- **Row**: Horizontal layout, mainAxisAlignment, crossAxisAlignment
- **Column**: Vertical layout, spacing
- **MediaQuery**: Screen detection and responsiveness
- **Expanded/Flexible**: Dynamic sizing
- **Multiple patterns**: Card, grid, master-detail, blog

Result: Fully responsive layouts that work on any device! 📱💻🖥️

