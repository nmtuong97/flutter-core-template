import 'package:flutter/material.dart';

import '../../widgets/glass_demo_background.dart';
import '../../widgets/liquid_glass_components.dart';

// TODO: Integrate flutter_liquid_glass package
// import 'package:flutter_liquid_glass/flutter_liquid_glass.dart' as liquid;

/// Liquid Glass Components Showcase
///
/// Demonstrates all available Liquid Glass UI components:
/// - Input components (TextField, Button, Switch)
/// - Container components (Dialog, ListTile, GridTile)
/// - Navigation components (BottomNavBar, TabBar)
class LiquidGlassComponentsPage extends StatefulWidget {
  const LiquidGlassComponentsPage({super.key});

  @override
  State<LiquidGlassComponentsPage> createState() =>
      _LiquidGlassComponentsPageState();
}

class _LiquidGlassComponentsPageState extends State<LiquidGlassComponentsPage>
    with SingleTickerProviderStateMixin {
  final _textController = TextEditingController();
  bool _switchValue = false;
  int _bottomNavIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _textController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassDemoBackground(
      useImage: true, // Enable decorative floating shapes
      child: Scaffold(
        backgroundColor: Colors.transparent, // Let background show through
        appBar: AppBar(
          title: const Text('Liquid Glass Components'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Section 1: Input Components
              _buildSectionTitle('Input Components', context),
              const SizedBox(height: 12),

              // TextField
              _buildSubtitle('LiquidGlassTextField', context),
              const SizedBox(height: 8),
              LiquidGlassTextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Enter text here...',
                  hintStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Buttons
              _buildSubtitle('LiquidGlassButton', context),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: LiquidGlassButton(
                      onPressed: () {
                        _showSnackBar(context, 'Regular button pressed');
                      },
                      child: const Text('Regular'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LiquidGlassButton(
                      onPressed: () {
                        _showSnackBar(context, 'Primary button pressed');
                      },
                      isPrimary: true,
                      child: const Text('Primary'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Icon Buttons
              _buildSubtitle('LiquidGlassIconButton', context),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LiquidGlassIconButton(
                    icon: Icons.favorite,
                    onPressed: () {
                      _showSnackBar(context, 'Favorite pressed');
                    },
                    tooltip: 'Favorite',
                  ),
                  LiquidGlassIconButton(
                    icon: Icons.share,
                    onPressed: () {
                      _showSnackBar(context, 'Share pressed');
                    },
                    tooltip: 'Share',
                  ),
                  LiquidGlassIconButton(
                    icon: Icons.bookmark,
                    onPressed: () {
                      _showSnackBar(context, 'Bookmark pressed');
                    },
                    tooltip: 'Bookmark',
                  ),
                  LiquidGlassIconButton(
                    icon: Icons.settings,
                    onPressed: () {
                      _showSnackBar(context, 'Settings pressed');
                    },
                    tooltip: 'Settings',
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Switch
              _buildSubtitle('LiquidGlassSwitch', context),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Enable notifications',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  LiquidGlassSwitch(
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Section 2: Container Components
              _buildSectionTitle('Container Components', context),
              const SizedBox(height: 12),

              // Dialog Button
              _buildSubtitle('LiquidGlassDialog', context),
              const SizedBox(height: 8),
              LiquidGlassButton(
                onPressed: () {
                  LiquidGlassDialog.show<void>(
                    context: context,
                    title: const Text('Glass Dialog'),
                    content: const Text(
                      'This is a beautiful dialog with glass effect. '
                      'It features blur backdrop and smooth animations.',
                    ),
                    actions: [
                      LiquidGlassButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      LiquidGlassButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showSnackBar(context, 'Confirmed');
                        },
                        isPrimary: true,
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
                child: const Text('Show Dialog'),
              ),
              const SizedBox(height: 16),

              // List Tiles
              _buildSubtitle('LiquidGlassListTile', context),
              const SizedBox(height: 8),
              LiquidGlassListTile(
                leading: const Icon(Icons.person),
                title: const Text('John Doe'),
                subtitle: const Text('Software Developer'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  _showSnackBar(context, 'List item tapped');
                },
              ),
              LiquidGlassListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: const Text('john.doe@example.com'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  _showSnackBar(context, 'Email tapped');
                },
              ),
              LiquidGlassListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Phone'),
                subtitle: const Text('+1 234 567 890'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  _showSnackBar(context, 'Phone tapped');
                },
              ),
              const SizedBox(height: 16),

              // Grid Tiles
              _buildSubtitle('LiquidGlassGridTile', context),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return LiquidGlassGridTile(
                      onTap: () {
                        _showSnackBar(context, 'Grid item ${index + 1} tapped');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getGridIcon(index),
                            size: 40,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Item ${index + 1}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Section 3: Navigation Components
              _buildSectionTitle('Navigation Components', context),
              const SizedBox(height: 12),

              // Tab Bar
              _buildSubtitle('LiquidGlassTabBar', context),
              const SizedBox(height: 8),
              LiquidGlassTabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Home'),
                  Tab(text: 'Explore'),
                  Tab(text: 'Profile'),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTabContent('Home', Icons.home),
                    _buildTabContent('Explore', Icons.explore),
                    _buildTabContent('Profile', Icons.person),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Bottom Nav Bar (static preview)
              _buildSubtitle('LiquidGlassBottomNavBar (Preview)', context),
              const SizedBox(height: 8),
              LiquidGlassBottomNavBar(
                currentIndex: _bottomNavIndex,
                onTap: (index) {
                  setState(() {
                    _bottomNavIndex = index;
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
                    icon: Icons.notifications_outlined,
                    activeIcon: Icons.notifications,
                    label: 'Alerts',
                  ),
                  LiquidGlassBottomNavBarItem(
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: 'Profile',
                  ),
                ],
              ),
              const SizedBox(height: 80), // Space for bottom padding
            ],
          ),
        ),
      ), // Close Scaffold
    ); // Close GlassDemoBackground
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildSubtitle(String title, BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
    );
  }

  Widget _buildTabContent(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Tab content goes here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }

  IconData _getGridIcon(int index) {
    switch (index) {
      case 0:
        return Icons.dashboard;
      case 1:
        return Icons.analytics;
      case 2:
        return Icons.settings;
      case 3:
        return Icons.help;
      default:
        return Icons.circle;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
