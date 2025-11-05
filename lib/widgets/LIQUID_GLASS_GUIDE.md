# Liquid Glass Components - Usage Guide

## Tổng Quan

Bộ components Liquid Glass cung cấp **14 components** với hiệu ứng glass morphism cho Flutter:

### 🎨 3 Cấp Độ Architecture

1. **Theme Layer** (`liquid_glass_theme.dart`): Colors, typography, base styling
2. **Base Components** (`liquid_glass.dart`): 5 base widgets
   - `LiquidGlass` - Base glass container
   - `AnimatedLiquidGlass` - Interactive với hover effects
   - `LiquidGlassCard` - Pre-configured card
   - `LiquidGlassAppBar` - Floating app bar
   - `LiquidGlassBottomSheet` - Modal sheet
3. **Specialized Components** (`liquid_glass_components.dart`): 9 UI components
   - Input: `LiquidGlassTextField`, `LiquidGlassButton`, `LiquidGlassIconButton`, `LiquidGlassSwitch`
   - Container: `LiquidGlassDialog`, `LiquidGlassListTile`, `LiquidGlassGridTile`
   - Navigation: `LiquidGlassBottomNavBar`, `LiquidGlassTabBar`

---

## 📦 Import

```dart
// Base components
import 'package:flutter_core_template/widgets/liquid_glass.dart';

// Specialized UI components
import 'package:flutter_core_template/widgets/liquid_glass_components.dart';
```

---

## 🚀 Quick Start Examples

### 1. TextField - Text Input với Glass Effect

```dart
LiquidGlassTextField(
  decoration: InputDecoration(
    hintText: 'Enter email',
    hintStyle: TextStyle(
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
    ),
  ),
  keyboardType: TextInputType.emailAddress,
  onChanged: (value) {
    print('Input: $value');
  },
)
```

**Features:**
- Focus-responsive border: 0.75px → 2.0px
- Border color changes: gray → primary color
- Blur: 20.0 (medium blur for input)
- Auto context-adaptive colors

---

### 2. Button - Primary/Secondary Variants

```dart
// Primary Button
LiquidGlassButton(
  onPressed: () {
    print('Primary action');
  },
  isPrimary: true,
  child: Text('Submit'),
)

// Secondary Button
LiquidGlassButton(
  onPressed: () {
    print('Secondary action');
  },
  child: Text('Cancel'),
)
```

**Features:**
- Hover scale: 1.03x
- Primary: `theme.colorScheme.primary.withOpacity(0.9)`
- Secondary: Context-adaptive tint
- Padding: horizontal 24, vertical 16

---

### 3. IconButton - Circular Glass Button

```dart
LiquidGlassIconButton(
  icon: Icons.favorite,
  onPressed: () {
    print('Favorite pressed');
  },
  tooltip: 'Add to favorites',
  size: 48.0,
  iconSize: 24.0,
)
```

**Features:**
- Circular shape (borderRadius = size/2)
- Hover scale: 1.05x (more than regular button)
- Optional tooltip
- Customizable size and icon size

---

### 4. Switch - Animated Toggle

```dart
bool _isEnabled = false;

LiquidGlassSwitch(
  value: _isEnabled,
  onChanged: (value) {
    setState(() {
      _isEnabled = value;
    });
  },
)
```

**Features:**
- Size: 56x32 (iOS-like proportions)
- Animated thumb: 26x26 circle
- Animation: 200ms, easeOutCubic
- Active color: primary or custom

---

### 5. Dialog - Modal với Glass Effect

```dart
// Show dialog
LiquidGlassDialog.show<void>(
  context: context,
  title: Text('Confirm Action'),
  content: Text('Are you sure you want to proceed?'),
  actions: [
    LiquidGlassButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Cancel'),
    ),
    LiquidGlassButton(
      onPressed: () {
        Navigator.pop(context);
        // Perform action
      },
      isPrimary: true,
      child: Text('Confirm'),
    ),
  ],
)
```

**Features:**
- Blur: 30.0 (high blur for emphasis)
- Border radius: 24.0
- Shadow: blur 20, offset (0,10)
- Static `show()` method
- Optional title, content, actions

---

### 6. ListTile - List Item với Leading/Trailing

```dart
LiquidGlassListTile(
  leading: Icon(Icons.person),
  title: Text('John Doe'),
  subtitle: Text('Software Developer'),
  trailing: Icon(Icons.chevron_right),
  onTap: () {
    print('List item tapped');
  },
)
```

**Features:**
- Layout: leading - (title/subtitle) - trailing
- Hover scale: 1.01x (subtle)
- Margin: vertical 4, horizontal 8
- Padding: 12 all around

---

### 7. GridTile - Grid Item Wrapper

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    return LiquidGlassGridTile(
      onTap: () {
        print('Grid item $index tapped');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(items[index].icon, size: 40),
          SizedBox(height: 8),
          Text(items[index].name),
        ],
      ),
    );
  },
)
```

**Features:**
- Center-aligned child
- Hover scale: 1.02x
- Shadow: blur 10, offset (0,4)
- Padding: 16 all around

---

### 8. BottomNavBar - Navigation với Glass Effect

```dart
int _currentIndex = 0;

Scaffold(
  body: _pages[_currentIndex],
  bottomNavigationBar: LiquidGlassBottomNavBar(
    currentIndex: _currentIndex,
    onTap: (index) {
      setState(() {
        _currentIndex = index;
      });
    },
    items: const [
      LiquidGlassBottomNavBarItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        label: 'Home',
      ),
      LiquidGlassBottomNavBarItem(
        icon: Icons.search_outlined,
        activeIcon: Icons.search,
        label: 'Search',
      ),
      LiquidGlassBottomNavBarItem(
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        label: 'Profile',
      ),
    ],
  ),
)
```

**Features:**
- Item-based API
- Height: 70.0 (with SafeArea)
- Blur: 30.0
- Selected indicator: primary color
- Icons + labels, active/inactive states

---

### 9. TabBar - Tab Navigation với Glass Indicator

```dart
class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LiquidGlassTabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Home'),
            Tab(text: 'Explore'),
            Tab(text: 'Profile'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              HomePage(),
              ExplorePage(),
              ProfilePage(),
            ],
          ),
        ),
      ],
    );
  }
}
```

**Features:**
- Requires TabController
- Glass indicator với primary color
- Padding around tabs: 4px
- Indicator padding: 2px

---

## 🎛️ Customization Options

### Common Parameters

```dart
LiquidGlassButton(
  // Required
  onPressed: () {},
  child: Text('Button'),
  
  // Optional Customization
  blur: 20.0,              // Blur intensity (16-30)
  tint: Color(0x40000000), // Custom tint color
  borderRadius: 16.0,      // Corner radius
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.all(8),
  
  // Button-specific
  isPrimary: true,         // Primary vs secondary style
)
```

### Blur Intensity Guidelines

- **Low blur (16.0)**: Subtle glass effect
- **Medium blur (20-24)**: Standard glass effect (recommended)
- **High blur (28-30)**: Strong glass effect for modals/dialogs

### Context-Adaptive Colors

All components automatically adapt to light/dark mode:

```dart
// Light mode
tint: Color(0x26FFFFFF) // 15% white

// Dark mode
tint: Color(0x40000000) // 25% black
```

---

## ⚡ Performance Tips

### 1. Disable Blur on Low-End Devices

```dart
final isLowEndDevice = /* device detection logic */;

LiquidGlassButton(
  enableBlur: !isLowEndDevice, // Disable blur if needed
  onPressed: () {},
  child: Text('Button'),
)
```

### 2. Limit BackdropFilter Usage

- ❌ **DON'T**: Nest multiple glass components deeply
- ✅ **DO**: Use glass components sparingly at key UI elements

### 3. Use const Constructors

```dart
// ✅ Good
const LiquidGlassButton(
  child: Text('Static Button'),
)

// ❌ Bad (if content is static)
LiquidGlassButton(
  child: Text('Static Button'),
)
```

---

## 🎨 Best Practices

### ✅ DO

1. **Use glass components for focal points**: Buttons, dialogs, navigation
2. **Match blur intensity to component importance**: Higher blur for modals
3. **Keep hover animations subtle**: <5% scale (1.01-1.05x)
4. **Test on real devices**: GPU performance varies
5. **Combine with theme**: Use with Liquid Glass theme for consistency

### ❌ DON'T

1. **Nest glass components deeply**: BackdropFilter is GPU-intensive
2. **Use on background containers**: Only for interactive elements
3. **Animate blur in real-time**: Pre-defined blur values only
4. **Forget accessibility**: Maintain proper text contrast
5. **Overuse**: Glass effect loses impact if everything is glass

---

## 🔧 Troubleshooting

### Issue: Components không hiển thị blur

**Solution**: Kiểm tra `enableBlur` parameter và device GPU capability

```dart
LiquidGlassButton(
  enableBlur: true, // Ensure this is true
  blur: 24.0,       // Ensure blur > 0
  child: Text('Button'),
)
```

### Issue: Performance lag khi nhiều components

**Solution**: Giảm số lượng glass components hoặc giảm blur intensity

```dart
// Lower blur for better performance
LiquidGlassButton(
  blur: 16.0, // Instead of 30.0
  child: Text('Button'),
)
```

### Issue: Text contrast thấp

**Solution**: Tăng opacity của background color hoặc dùng brighter text colors

```dart
LiquidGlassButton(
  tint: Color(0x60000000), // Higher opacity (60% vs 40%)
  child: Text(
    'Button',
    style: TextStyle(
      color: Colors.white, // Explicit white text
      fontWeight: FontWeight.w600,
    ),
  ),
)
```

---

## 📱 Testing

### Run Demo Pages

```bash
# Run app
flutter run

# In app:
# 1. Tap "Auto Awesome" icon (✨) in AppBar → Full components showcase
# 2. Tap "Blur On" icon in AppBar → Base components demo
```

### Demo Pages Location

- **Components Showcase**: `lib/presentation/pages/liquid_glass_components_page.dart`
- **Base Demo**: `lib/presentation/pages/liquid_glass_demo_page.dart`

---

## 🚀 Next Steps

1. ✅ **Test components in your app**
2. ✅ **Replace standard widgets với glass variants**
3. ✅ **Measure performance on target devices**
4. ✅ **Customize blur/tint for your design**
5. ✅ **Share feedback for improvements**

---

## 📚 Additional Resources

- **Theme Documentation**: `lib/theme/README.md`
- **Architecture Guide**: `.github/copilot-instructions.md`
- **Base Components Source**: `lib/widgets/liquid_glass.dart`
- **Specialized Components Source**: `lib/widgets/liquid_glass_components.dart`

---

## 🎯 Summary

Bạn có **14 glass components** sẵn sàng:

**Input**: TextField ✓ Button ✓ IconButton ✓ Switch ✓
**Container**: Dialog ✓ ListTile ✓ GridTile ✓ Card ✓
**Navigation**: BottomNavBar ✓ TabBar ✓ AppBar ✓ BottomSheet ✓
**Base**: LiquidGlass ✓ AnimatedLiquidGlass ✓

**Chỉ cần import và sử dụng!** 🎉
