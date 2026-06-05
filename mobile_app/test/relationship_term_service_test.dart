import 'package:flutter_test/flutter_test.dart';
import 'package:vansha_mobile/features/family/domain/relationship_term_service.dart';

void main() {
  const service = RelationshipTermService();

  test('returns the mother tongue term for an exact language tag', () {
    expect(
      service.termFor(
        canonicalRelationship: 'father',
        languageTag: 'te-IN',
      ),
      'Naanna',
    );
    expect(
      service.termFor(
        canonicalRelationship: 'father',
        languageTag: 'ta-IN',
      ),
      'Appā',
    );
    expect(
      service.termFor(
        canonicalRelationship: 'father',
        languageTag: 'ml-IN',
      ),
      'Achan',
    );
  });

  test('matches a regional language tag by base language', () {
    expect(
      service.termFor(
        canonicalRelationship: 'mother',
        languageTag: 'te-US',
      ),
      'Ammā',
    );
  });

  test('keeps English-only display for English or ambiguous relationships', () {
    expect(
      service.termFor(
        canonicalRelationship: 'father',
        languageTag: 'en-IN',
      ),
      isNull,
    );
    expect(
      service.termFor(
        canonicalRelationship: 'paternal_uncle',
        languageTag: 'te-IN',
      ),
      isNull,
    );
  });
}
