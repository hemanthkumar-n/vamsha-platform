import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/family_graph_data.dart';
import 'family_graph_repository.dart';

class SupabaseFamilyGraphRepository implements FamilyGraphRepository {
  final SupabaseClient client;
  final String datasetKey;

  const SupabaseFamilyGraphRepository({
    required this.client,
    this.datasetKey = 'founder_family',
  });

  @override
  Future<FamilyGraphData> load() async {
    final row = await client
        .from('family_graph_datasets')
        .select('graph_data')
        .eq('dataset_key', datasetKey)
        .eq('is_active', true)
        .single();

    return FamilyGraphData.fromJson(
      Map<String, dynamic>.from(row['graph_data'] as Map),
    );
  }
}
