import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/family/presentation/viewer_family_web_screen.dart';
import 'features/family/web/founder_family_web_screen.dart';

// import 'features/onboarding/presentation/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tkxjswvwssbdxtrxpvzt.supabase.co',
    anonKey: 'sb_publishable_w2ka46iDnts0f2kLak3qEA_bpvWHP4j',
  );

  runApp(const VamshaApp());
}

class VamshaApp extends StatelessWidget {
  const VamshaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamsha',
      debugShowCheckedModeBanner: false,
      home: const FounderFamilyWebScreen(),
    );
  }
}
