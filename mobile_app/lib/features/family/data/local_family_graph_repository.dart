import '../models/family_graph_data.dart';
import '../models/founder_graph.dart';
import 'family_graph_repository.dart';

class LocalFamilyGraphRepository implements FamilyGraphRepository {
  const LocalFamilyGraphRepository();

  @override
  Future<FamilyGraphData> load() async => FounderGraph.localData;
}
