import 'package:flutter/material.dart';

import 'features/family/presentation/relationship_projection_demo_screen.dart';

void main() {
  runApp(const VamshaApp());
}

class VamshaApp extends StatelessWidget {
  const VamshaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Vamsha',
      debugShowCheckedModeBanner: false,
      home: RelationshipProjectionDemoScreen(),
    );
  }
}
