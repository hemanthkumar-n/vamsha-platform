import '../models/family_graph_data.dart';

abstract interface class FamilyGraphRepository {
  Future<FamilyGraphData> load();
}
