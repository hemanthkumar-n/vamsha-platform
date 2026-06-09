import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/family/data/family_graph_bootstrap.dart';
import 'features/family/models/founder_graph.dart';
import 'features/family/presentation/vamsha_home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FounderGraph.install(await FamilyGraphBootstrap.load());
  runApp(const VamshaApp());
}

class VamshaApp extends StatelessWidget {
  const VamshaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamsha',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const VamshaHomeScreen(),
    );
  }
}
