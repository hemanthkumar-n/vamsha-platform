import '../models/founder_graph.dart';
import '../models/relationship_edge.dart';

class GraphBuilderService {
  static List<Map<String, dynamic>> buildNodes() {
    return FounderGraph.people.map((p) {
      return {
        'id': p.id,
        'name': p.primaryName,
        'aliases': p.aliases,
        'knownAs': p.knownAs,
      };
    }).toList();
  }

  static List<RelationshipEdge> buildEdges() {
    return FounderGraph.relationships;
  }
}
