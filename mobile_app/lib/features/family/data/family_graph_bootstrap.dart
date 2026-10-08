import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/family_graph_data.dart';
import 'fallback_family_graph_repository.dart';
import 'local_profiles/local_profile_store.dart';
import 'local_profiles/open_profile_database.dart';
import 'local_family_graph_repository.dart';
import 'supabase_family_graph_repository.dart';

class FamilyGraphBootstrap {
  static const _supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const _supabasePublishableKey =
      String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');

  const FamilyGraphBootstrap._();

  static Future<FamilyGraphData> load() async {
    final profileStore = LocalProfileStore(await openProfileDatabase());
    LocalProfileStore.current = profileStore;
    const local = LocalFamilyGraphRepository();
    if (_supabaseUrl.isEmpty || _supabasePublishableKey.isEmpty) {
      return profileStore.applyTo(await local.load());
    }

    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabasePublishableKey,
      debug: false,
    );

    final graph = await FallbackFamilyGraphRepository(
      primary: SupabaseFamilyGraphRepository(
        client: Supabase.instance.client,
      ),
      fallback: local,
    ).load().timeout(
          const Duration(seconds: 6),
          onTimeout: local.load,
        );
    return profileStore.applyTo(graph);
  }
}
