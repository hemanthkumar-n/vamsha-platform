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
    final divya = service.project(viewerId: 'hemanth', targetId: 'divya');
    expect(divya.relationship, 'Sister');
    expect(divya.culturalRelationship, 'Chelli');
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
    final kamesh = service.project(viewerId: 'hemanth', targetId: 'kamesh');
    expect(kamesh.relationship, 'Brother-in-law');
    expect(kamesh.culturalRelationship, 'Bava');
  });

  test('applies Hemanth paternal family calling memories', () {
    final mallikarjuna = service.project(
      viewerId: 'hemanth',
      targetId: 'mallikarjuna',
    );
    final akalhya = service.project(
      viewerId: 'hemanth',
      targetId: 'akalhya',
    );
    final sandhya = service.project(
      viewerId: 'hemanth',
      targetId: 'sandhya',
    );
    final usha = service.project(
      viewerId: 'hemanth',
      targetId: 'usha',
    );

    expect(mallikarjuna.relationship, 'Paternal Uncle');
    expect(mallikarjuna.culturalRelationship, 'Pedhananna');
    expect(akalhya.relationship, 'Paternal Aunt');
    expect(akalhya.culturalRelationship, 'Pedha Attha');
    expect(sandhya.relationship, 'Paternal Aunt');
    expect(sandhya.culturalRelationship, 'Naanna Akka');
    expect(usha.relationship, 'Paternal Aunt');
    expect(usha.culturalRelationship, 'Attha');

    final radha = service.project(
      viewerId: 'hemanth',
      targetId: 'radha',
    );
    expect(radha.relationship, 'Maternal Aunt');
    expect(radha.culturalRelationship, 'Pinni');
  });

  test('uses sibling order for Anna and younger sibling relationships', () {
    final hemanthFromDivya = service.project(
      viewerId: 'divya',
      targetId: 'hemanth',
    );
    final divyaFromHemanth = service.project(
      viewerId: 'hemanth',
      targetId: 'divya',
    );

    expect(hemanthFromDivya.canonicalRelationship, 'elder_brother');
    expect(hemanthFromDivya.relationship, 'Elder Brother');
    expect(hemanthFromDivya.culturalRelationship, 'Anna');
    expect(divyaFromHemanth.canonicalRelationship, 'younger_sister');
    expect(divyaFromHemanth.relationship, 'Sister');
    expect(divyaFromHemanth.culturalRelationship, 'Chelli');
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
    final fathersYoungerSister = service.project(
      viewerId: 'yuvan',
      targetId: 'divya',
    );
    expect(fathersYoungerSister.canonicalRelationship,
        'paternal_aunt_fathers_sister');
    expect(fathersYoungerSister.relationship, "Father's Younger Sister");
    expect(fathersYoungerSister.culturalRelationship, 'Atha');
  });

  test('applies Yuvan calling names for his paternal aunt family', () {
    final uncle = service.project(viewerId: 'yuvan', targetId: 'kamesh');
    expect(
        uncle.canonicalRelationship, 'paternal_uncle_fathers_sisters_husband');
    expect(uncle.relationship, "Father's Sister's Husband");
    expect(uncle.culturalRelationship, 'Mamaiya');

    for (final entry in {
      'shreasta': 'Maradhal',
      'vedhansh': 'Thamudu',
      'krithiksha': 'Maradhal',
    }.entries) {
      final cousin = service.project(viewerId: 'yuvan', targetId: entry.key);
      expect(cousin.canonicalRelationship, 'cousin');
      expect(cousin.relationship, 'Cousin');
      expect(cousin.culturalRelationship, entry.value);
    }
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
      'Elder Brother',
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

    for (final parentId in [
      'doguparthi_siva_prasad',
      'doguparthi_jayamma',
    ]) {
      final hemanthAsSonInLaw = service.project(
        viewerId: parentId,
        targetId: 'hemanth',
      );
      expect(hemanthAsSonInLaw.relationship, 'Son-in-law');
      expect(hemanthAsSonInLaw.culturalRelationship, 'Alludu');
    }
  });

  test('projects Kiran relationships using precise graph paths', () {
    final father = service.project(
      viewerId: 'doguparthi_kiran',
      targetId: 'doguparthi_siva_prasad',
    );
    final mother = service.project(
      viewerId: 'doguparthi_kiran',
      targetId: 'doguparthi_jayamma',
    );
    final sister = service.project(
      viewerId: 'doguparthi_kiran',
      targetId: 'keerthi',
    );
    final sistersHusband = service.project(
      viewerId: 'doguparthi_kiran',
      targetId: 'hemanth',
    );
    final sistersSon = service.project(
      viewerId: 'doguparthi_kiran',
      targetId: 'yuvan',
    );

    expect(father.relationship, 'Father');
    expect(mother.relationship, 'Mother');
    expect(sister.canonicalRelationship, 'younger_sister');
    expect(sister.relationship, 'Younger Sister');
    expect(sister.culturalRelationship, 'Chelli');
    final elderBrother = service.project(
      viewerId: 'keerthi',
      targetId: 'doguparthi_kiran',
    );
    expect(elderBrother.canonicalRelationship, 'elder_brother');
    expect(elderBrother.culturalRelationship, 'Anna');
    expect(
        sistersHusband.canonicalRelationship, 'brother_in_law_sisters_husband');
    expect(sistersHusband.relationship, 'Brother-in-law');
    expect(sistersHusband.culturalRelationship, 'Bāvagāru');
    expect(sistersSon.canonicalRelationship, 'nephew_sisters_son');
    expect(sistersSon.relationship, 'Nephew');
    expect(sistersSon.culturalRelationship, 'Alludu');
  });

  test('applies Jayamma family calling conventions', () {
    final divya = service.project(
      viewerId: 'doguparthi_jayamma',
      targetId: 'divya',
    );
    final kamesh = service.project(
      viewerId: 'doguparthi_jayamma',
      targetId: 'kamesh',
    );

    expect(divya.relationship, 'Daughter-in-law');
    expect(divya.culturalRelationship, 'Kodalu');
    expect(kamesh.relationship, 'Son');
    expect(kamesh.culturalRelationship, 'Koduku');
  });

  test('applies Jayamma calling conventions for Kamesh children', () {
    final shreasta = service.project(
      viewerId: 'doguparthi_jayamma',
      targetId: 'shreasta',
    );
    final vedhansh = service.project(
      viewerId: 'doguparthi_jayamma',
      targetId: 'vedhansh',
    );
    final krithiksha = service.project(
      viewerId: 'doguparthi_jayamma',
      targetId: 'krithiksha',
    );

    expect(shreasta.relationship, 'Granddaughter');
    expect(shreasta.culturalRelationship, 'Kodalu');
    expect(vedhansh.relationship, 'Grandson');
    expect(vedhansh.culturalRelationship, 'Alludu');
    expect(krithiksha.relationship, 'Granddaughter');
    expect(krithiksha.culturalRelationship, 'Kodalu');
  });

  test('applies Hemanth calling conventions for Divya children', () {
    final shreasta = service.project(
      viewerId: 'hemanth',
      targetId: 'shreasta',
    );
    final vedhansh = service.project(
      viewerId: 'hemanth',
      targetId: 'vedhansh',
    );
    final krithiksha = service.project(
      viewerId: 'hemanth',
      targetId: 'krithiksha',
    );

    expect(shreasta.relationship, 'Niece');
    expect(shreasta.culturalRelationship, 'Kodalu');
    expect(vedhansh.relationship, 'Nephew');
    expect(vedhansh.culturalRelationship, 'Alludu');
    expect(krithiksha.relationship, 'Niece');
    expect(krithiksha.culturalRelationship, 'Kodalu');
  });
}
