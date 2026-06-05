import 'package:flutter_test/flutter_test.dart';
import 'package:vansha_mobile/features/family/models/founder_graph.dart';
import 'package:vansha_mobile/features/family/models/person_entity.dart';
import 'package:vansha_mobile/features/family/models/person_profile_metadata.dart';

void main() {
  test('person profile has safe language and location defaults', () {
    const person = PersonEntity(
      id: 'person',
      primaryName: 'Example Person',
    );

    expect(person.languageProfile.uiLanguageTag, 'en');
    expect(person.languageProfile.motherTongueTag, 'und');
    expect(person.languageProfile.fluentLanguageTags, isEmpty);
    expect(person.languageProfile.primaryRelationshipLanguageTag, 'en');
    expect(person.location.countryCode, isNull);
    expect(person.culturalProfile.religion, isNull);
  });

  test('mother tongue remains authoritative over fluent languages', () {
    const profile = PersonLanguageProfile(
      uiLanguageTag: 'en-IN',
      motherTongueTag: 'te-IN',
      fluentLanguageTags: ['ta-IN', 'ml-IN'],
    );

    expect(profile.primaryRelationshipLanguageTag, 'te-IN');
  });

  test('fluent language is used only when mother tongue is unspecified', () {
    const profile = PersonLanguageProfile(
      uiLanguageTag: 'en-IN',
      fluentLanguageTags: ['ml-IN', 'ta-IN'],
    );

    expect(profile.primaryRelationshipLanguageTag, 'ml-IN');
  });

  test('founder family is Telugu and Hemanth records additional fluency', () {
    for (final person in FounderGraph.people) {
      expect(
        person.languageProfile.motherTongueTag,
        'te-IN',
        reason: '${person.primaryName} should use Telugu calling terms',
      );
    }

    final hemanth = FounderGraph.personById('hemanth');
    expect(
      hemanth.languageProfile.fluentLanguageTags,
      containsAll(['te-IN', 'ta-IN', 'ml-IN', 'en-IN']),
    );
    expect(hemanth.languageProfile.motherTongueName, 'Telugu');
  });
}
