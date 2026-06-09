import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/family_graph_data.dart';
import 'fallback_family_graph_repository.dart';
import 'local_family_graph_repository.dart';
import 'supabase_family_graph_repository.dart';

class FamilyGraphBootstrap {
  static const _supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const _supabasePublishableKey =
      String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');

  const FamilyGraphBootstrap._();

  static Future<FamilyGraphData> load() async {
    const local = LocalFamilyGraphRepository();
    if (_supabaseUrl.isEmpty || _supabasePublishableKey.isEmpty) {
      return local.load();
    }

    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabasePublishableKey,
      debug: false,
    );

    return FallbackFamilyGraphRepository(
      primary: SupabaseFamilyGraphRepository(
        client: Supabase.instance.client,
      ),
      fallback: local,
    ).load();
  }
}
