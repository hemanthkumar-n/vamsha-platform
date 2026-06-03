import 'package:flutter/material.dart';

import '../web/founder_family_web_screen.dart';
import 'relationship_projection_demo_screen.dart';

class VamshaHomeScreen extends StatefulWidget {
  const VamshaHomeScreen({super.key});

  @override
  State<VamshaHomeScreen> createState() => _VamshaHomeScreenState();
}

class _VamshaHomeScreenState extends State<VamshaHomeScreen> {
  int _selectedIndex = 0;

  static const _screens = <Widget>[
    FounderFamilyWebScreen(),
    RelationshipProjectionDemoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.account_tree_outlined),
            selectedIcon: Icon(Icons.account_tree),
            label: 'Family Web',
          ),
          NavigationDestination(
            icon: Icon(Icons.compare_arrows_outlined),
            selectedIcon: Icon(Icons.compare_arrows),
            label: 'Projection',
          ),
        ],
      ),
    );
  }
}
