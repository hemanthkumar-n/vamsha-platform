import '../models/family_graph_data.dart';
import 'family_graph_repository.dart';

class FallbackFamilyGraphRepository implements FamilyGraphRepository {
  final FamilyGraphRepository primary;
  final FamilyGraphRepository fallback;

  const FallbackFamilyGraphRepository({
    required this.primary,
    required this.fallback,
  });

  @override
  Future<FamilyGraphData> load() async {
    try {
      return await primary.load();
    } catch (_) {
      return fallback.load();
    }
  }
}
