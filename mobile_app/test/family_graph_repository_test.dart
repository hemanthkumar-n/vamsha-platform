import 'package:flutter_test/flutter_test.dart';
import 'package:vansha_mobile/features/family/data/fallback_family_graph_repository.dart';
import 'package:vansha_mobile/features/family/data/family_graph_repository.dart';
import 'package:vansha_mobile/features/family/data/local_family_graph_repository.dart';
import 'package:vansha_mobile/features/family/domain/relationship_projection_service.dart';
import 'package:vansha_mobile/features/family/models/family_graph_data.dart';
import 'package:vansha_mobile/features/family/models/founder_graph.dart';

void main() {
  tearDown(FounderGraph.reset);

  test('founder graph survives a JSON round trip', () {
    final restored = FamilyGraphData.fromJson(FounderGraph.localData.toJson());

    expect(restored.people.length, FounderGraph.localData.people.length);
    expect(
      restored.familyUnits.length,
      FounderGraph.localData.familyUnits.length,
    );
    expect(
      restored.relationships.length,
      FounderGraph.localData.relationships.length,
    );
    expect(
      restored.viewerRelationshipOverrides.length,
      FounderGraph.localData.viewerRelationshipOverrides.length,
    );
    expect(
      restored.people.firstWhere((person) => person.id == 'radha').aliases,
      contains('Dhampuri Radha Rani'),
    );
  });

  test('repository falls back to the local founder graph', () async {
    final repository = FallbackFamilyGraphRepository(
      primary: _FailingFamilyGraphRepository(),
      fallback: const LocalFamilyGraphRepository(),
    );

    final graph = await repository.load();

    expect(graph.people, isNotEmpty);
    expect(graph.people.any((person) => person.id == 'hemanth'), isTrue);
  });

  test('an installed repository graph drives relationship projections', () {
    final graph = FamilyGraphData.fromJson(FounderGraph.localData.toJson());
    FounderGraph.install(graph);

    const service = RelationshipProjectionService();
    final projection = service.project(
      viewerId: 'hemanth',
      targetId: 'radha',
    );

    expect(projection.relationship, 'Maternal Aunt');
    expect(projection.culturalRelationship, 'Pinni');
  });
}

class _FailingFamilyGraphRepository implements FamilyGraphRepository {
  @override
  Future<FamilyGraphData> load() {
    throw StateError('Supabase unavailable');
  }
}
