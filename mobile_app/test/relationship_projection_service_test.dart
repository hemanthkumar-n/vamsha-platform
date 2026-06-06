import 'package:flutter_test/flutter_test.dart';
import 'package:vansha_mobile/features/family/domain/relationship_projection_service.dart';

void main() {
  const service = RelationshipProjectionService();

  test('projects Hemanth family labels from graph structure', () {
    final father = service.project(viewerId: 'hemanth', targetId: 'prasad');
    final mother = service.project(viewerId: 'hemanth', targetId: 'sudha');

    expect(father.relationship, 'Father');
    expect(father.canonicalRelationship, 'father');
    expect(father.culturalRelationship, 'Naanna');
    expect(mother.relationship, 'Mother');
    expect(mother.culturalRelationship, 'Ammā');
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
    expect(fatherInLaw.culturalRelationship, 'Māvagāru');
    expect(motherInLaw.relationship, 'Mother-in-law');
    expect(motherInLaw.culturalRelationship, 'Attagāru');
  });

  test('projects Sudha close family labels across marriage and descendants',
      () {
    expect(
      service.project(viewerId: 'sudha', targetId: 'mallikarjuna').relationship,
      'Brother-in-law',
    );
    expect(
      service.project(viewerId: 'sudha', targetId: 'keerthi').relationship,
      'Daughter-in-law',
    );
    expect(
      service.project(viewerId: 'sudha', targetId: 'kamesh').relationship,
      'Son-in-law',
    );
    final grandson = service.project(viewerId: 'sudha', targetId: 'yuvan');
    expect(grandson.relationship, 'Grandson');
    expect(grandson.culturalRelationship, 'Manavadu');
    expect(
      service.project(viewerId: 'sudha', targetId: 'shreasta').relationship,
      'Granddaughter',
    );
  });

  test('projects Keerthi and Yuvan viewer relationships', () {
    expect(
      service.project(viewerId: 'keerthi', targetId: 'hemanth').relationship,
      'Husband',
    );
    expect(
      service.project(viewerId: 'keerthi', targetId: 'yuvan').relationship,
      'Son',
    );
    expect(
      service.project(viewerId: 'keerthi', targetId: 'sudha').relationship,
      'Mother-in-law',
    );
    expect(
      service.project(viewerId: 'yuvan', targetId: 'keerthi').relationship,
      'Mother',
    );
    expect(
      service.project(viewerId: 'yuvan', targetId: 'hemanth').relationship,
      'Father',
    );
    expect(
      service.project(viewerId: 'yuvan', targetId: 'divya').relationship,
      'Paternal Aunt',
    );
  });

  test('projects the Doguparthi birth family and Hemanth in-laws', () {
    expect(
      service
          .project(
            viewerId: 'keerthi',
            targetId: 'doguparthi_siva_prasad',
          )
          .relationship,
      'Father',
    );
    expect(
      service
          .project(viewerId: 'keerthi', targetId: 'doguparthi_jayamma')
          .relationship,
      'Mother',
    );
    expect(
      service
          .project(viewerId: 'keerthi', targetId: 'doguparthi_kiran')
          .relationship,
      'Brother',
    );
    expect(
      service
          .project(
            viewerId: 'hemanth',
            targetId: 'doguparthi_siva_prasad',
          )
          .relationship,
      'Father-in-law',
    );
    expect(
      service
          .project(viewerId: 'hemanth', targetId: 'doguparthi_jayamma')
          .relationship,
      'Mother-in-law',
    );
    expect(
      service
          .project(viewerId: 'hemanth', targetId: 'doguparthi_kiran')
          .relationship,
      'Brother-in-law',
    );
  });
}
