# Scrollable Views - Quick Reference Guide

## 🚀 Quick Comparison

| Feature | ListView | ListView.builder | ListView.separated | GridView | GridView.builder |
|---------|----------|------------------|-------------------|----------|------------------|
| **Best For** | Small lists | Large datasets | Lists with dividers | 2D grids | Large grids |
| **Performance** | Poor (large) | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Medium | ⭐⭐⭐⭐⭐ |
| **Memory** | High | Low | Low | High | Low |
| **Lazy Load** | ❌ No | ✅ Yes | ✅ Yes | ❌ No | ✅ Yes |
| **Item Count** | Unknown | Known | Known | Unknown | Known |
| **Complexity** | Simple | Medium | Medium | Medium | Medium |

---

## 📋 Quick Snippets

### Basic ListView
```dart
ListView(
  children: [
    ListTile(title: Text('Item 1')),
    ListTile(title: Text('Item 2')),
  ],
)
```

### Efficient ListView (Large Data)
```dart
ListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) {
    return ListTile(title: Text('Item $index'));
  },
)
```

### ListView with Separators
```dart
ListView.separated(
  itemCount: 20,
  separatorBuilder: (_, __) => Divider(),
  itemBuilder: (context, index) {
    return ListTile(title: Text('Item $index'));
  },
)
```

### Horizontal ListView
```dart
ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: 10,
  itemBuilder: (context, index) {
    return Container(width: 150, child: Center(child: Text('$index')));
  },
)
```

### Basic GridView
```dart
GridView.count(
  crossAxisCount: 2,
  children: List.generate(12, (index) {
    return Container(color: Colors.blue);
  }),
)
```

### Efficient GridView (Large Data)
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
  ),
  itemCount: 1000,
  itemBuilder: (context, index) {
    return Container(color: Colors.blue);
  },
)
```

### Responsive GridView
```dart
int columns = MediaQuery.of(context).size.width < 600 ? 2 : 3;

GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: columns,
  ),
  itemBuilder: (context, index) => ...,
)
```

### Combined ListView + GridView
```dart
SingleChildScrollView(
  child: Column(
    children: [
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
      ),
      GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => Container(),
      ),
    ],
  ),
)
```

### Search/Filter List
```dart
class SearchableList extends StatefulWidget {
  @override
  State<SearchableList> createState() => _SearchableListState();
}

class _SearchableListState extends State<SearchableList> {
  List<String> items = ['Apple', 'Banana', 'Cherry'];
  List<String> filtered = [];

  @override
  void initState() {
    super.initState();
    filtered = items;
  }

  void _filterItems(String query) {
    setState(() {
      filtered = items.where((item) => 
        item.toLowerCase().contains(query.toLowerCase())
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: _filterItems,
          decoration: InputDecoration(hintText: 'Search...'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(filtered[index]));
            },
          ),
        ),
      ],
    );
  }
}
```

---

## 🎨 Common Patterns

### Infinite Scroll with Pagination
```dart
ListView.builder(
  itemCount: items.length + (hasMore ? 1 : 0),
  itemBuilder: (context, index) {
    if (index == items.length) {
      _loadMore();
      return CircularProgressIndicator();
    }
    return ListTile(title: Text(items[index]));
  },
)
```

### Pull-to-Refresh
```dart
RefreshIndicator(
  onRefresh: () async {
    await _refreshData();
  },
  child: ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      return ListTile(title: Text(items[index]));
    },
  ),
)
```

### Swipe to Delete
```dart
Dismissible(
  key: Key(items[index]),
  onDismissed: (direction) {
    setState(() => items.removeAt(index));
  },
  child: ListTile(title: Text(items[index])),
)
```

### Pinned Header
```dart
CustomScrollView(
  slivers: [
    SliverAppBar(
      pinned: true,
      title: Text('Header'),
    ),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(title: Text('Item $index')),
        childCount: 100,
      ),
    ),
  ],
)
```

### Sticky Section Headers
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    if (_isNewSection(index)) {
      return Container(
        color: Colors.grey,
        child: Text(_getSectionTitle(index)),
      );
    }
    return ListTile(title: Text(items[index]));
  },
)
```

---

## ⚙️ Common Properties

### ListView Properties
```dart
ListView(
  // Scroll direction
  scrollDirection: Axis.vertical,
  
  // Scroll physics (iOS, Android, or custom)
  physics: BouncingScrollPhysics(),
  
  // Padding
  padding: EdgeInsets.all(16),
  
  // Shrink to content size
  shrinkWrap: true,
  
  // Reverse order
  reverse: false,
  
  // Primary (captures top-level scroll)
  primary: true,
  
  // Controller for programmatic scrolling
  controller: ScrollController(),
)
```

### GridView Properties
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    // Number of columns
    crossAxisCount: 2,
    
    // Width-to-height ratio
    childAspectRatio: 1.0,
    
    // Space between rows
    mainAxisSpacing: 10,
    
    // Space between columns
    crossAxisSpacing: 10,
  ),
  
  // Same as ListView...
  physics: ScrollPhysics(),
  padding: EdgeInsets.all(8),
  shrinkWrap: true,
)
```

### ListTile Properties
```dart
ListTile(
  // Leading icon/widget
  leading: Icon(Icons.person),
  
  // Main title
  title: Text('Title'),
  
  // Subtitle below title
  subtitle: Text('Subtitle'),
  
  // Trailing icon/widget
  trailing: Icon(Icons.arrow_forward),
  
  // Callback on tap
  onTap: () {},
  
  // Background color on tap
  selectedColor: Colors.blue,
  
  // Dense (compact) list
  dense: false,
)
```

---

## 🎯 Physics Options

```dart
// Bouncy (iOS-like)
physics: BouncingScrollPhysics()

// Clamping (Android-like)
physics: ClampingScrollPhysics()

// No scrolling (for nested lists)
physics: NeverScrollableScrollPhysics()

// Always scroll
physics: AlwaysScrollableScrollPhysics()

// Custom behavior
physics: CustomScrollPhysics()
```

---

## 📊 Performance Checklist

- [ ] Use `.builder` for lists with 20+ items
- [ ] Provide `itemCount` for proper optimization
- [ ] Use `const` constructors where possible
- [ ] Use `NeverScrollableScrollPhysics` for nested lists
- [ ] Implement pagination for 1000+ items
- [ ] Cache images with `cacheHeight`/`cacheWidth`
- [ ] Use `ValueKey` for dynamic lists
- [ ] Debounce search operations
- [ ] Use `shrinkWrap: true` in columns
- [ ] Avoid rebuilding entire lists on filter

---

## 🚨 Common Mistakes

❌ **No itemCount in builder**
```dart
ListView.builder(
  itemBuilder: (context, index) => ..., // Missing itemCount!
)
```

✅ **Correct:**
```dart
ListView.builder(
  itemCount: 100,
  itemBuilder: (context, index) => ...,
)
```

---

❌ **Nested scrolling without physics**
```dart
Column(
  children: [
    ListView(...), // Will cause issues!
    GridView(...),
  ],
)
```

✅ **Correct:**
```dart
SingleChildScrollView(
  child: Column(
    children: [
      ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
      GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    ],
  ),
)
```

---

❌ **Not using const**
```dart
ListTile(
  leading: Icon(Icons.person), // Not const
  title: Text('Item'),
)
```

✅ **Correct:**
```dart
const ListTile(
  leading: Icon(Icons.person),
  title: Text('Item'),
)
```

---

## 📱 Screen Size Breakpoints

```dart
const double mobile = 480;
const double tablet = 768;
const double desktop = 1200;

bool isMobile(BuildContext context) => 
  MediaQuery.of(context).size.width < tablet;

bool isTablet(BuildContext context) => 
  MediaQuery.of(context).size.width >= tablet && 
  MediaQuery.of(context).size.width < desktop;

bool isDesktop(BuildContext context) => 
  MediaQuery.of(context).size.width >= desktop;

// Usage:
int gridColumns = isMobile(context) ? 2 : isTablet(context) ? 3 : 4;
```

---

## 🔗 Related Widgets

- **SingleChildScrollView** - Simple scrollable container
- **CustomScrollView** - Advanced scrolling with slivers
- **SliverList** - Efficient list with slivers
- **SliverGrid** - Efficient grid with slivers
- **SliverAppBar** - Collapsible app bar
- **NestedScrollView** - Multiple scrollables
- **ScrollController** - Programmatic scrolling
- **Scrollbar** - Visual scroll indicator

---

## 📖 Study Order

1. **Week 1:** Learn basic ListView and GridView
2. **Week 2:** Master ListView.builder and lazy loading
3. **Week 3:** Implement responsive grids
4. **Week 4:** Combine multiple scrollables
5. **Week 5:** Add search/filter functionality
6. **Week 6:** Implement pagination
7. **Week 7:** Optimize with CustomScrollView & Slivers

