import 'package:flutter_test/flutter_test.dart';
import 'package:vansha_mobile/features/family/domain/relationship_projection_service.dart';

void main() {
  const service = RelationshipProjectionService();

  test('projects Hemanth family labels from graph structure', () {
    expect(
        service.project(viewerId: 'hemanth', targetId: 'prasad').relationship,
        'Father');
    expect(service.project(viewerId: 'hemanth', targetId: 'sudha').relationship,
        'Mother');
    expect(service.project(viewerId: 'hemanth', targetId: 'divya').relationship,
        'Sister');
    expect(
        service.project(viewerId: 'hemanth', targetId: 'keerthi').relationship,
        'Wife');
    expect(
        service
            .project(viewerId: 'hemanth', targetId: 'mallikarjuna')
            .relationship,
        'Paternal Uncle');
    expect(service.project(viewerId: 'hemanth', targetId: 'radha').relationship,
        'Maternal Aunt');
    expect(
        service.project(viewerId: 'hemanth', targetId: 'vedhansh').relationship,
        'Nephew');
    expect(
        service.project(viewerId: 'hemanth', targetId: 'kamesh').relationship,
        'Brother-in-law');
  });

  test('projects Sudha in-law labels and cultural terms from graph structure',
      () {
    final fatherInLaw =
        service.project(viewerId: 'sudha', targetId: 'narendranath');
    final motherInLaw =
        service.project(viewerId: 'sudha', targetId: 'lakshmikanthamma');

    expect(service.project(viewerId: 'sudha', targetId: 'prasad').relationship,
        'Husband');
    expect(fatherInLaw.relationship, 'Father-in-law');
    expect(fatherInLaw.culturalRelationship, 'Mamayya');
    expect(motherInLaw.relationship, 'Mother-in-law');
    expect(motherInLaw.culturalRelationship, 'Athamma');
  });
}
