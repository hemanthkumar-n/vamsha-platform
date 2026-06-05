import 'relationship_terms_generated.dart';

class RelationshipTermService {
  const RelationshipTermService();

  String? termFor({
    required String canonicalRelationship,
    required String languageTag,
  }) {
    if (languageTag == 'en' || languageTag.startsWith('en-')) {
      return null;
    }

    final terms = relationshipTermsByCode[canonicalRelationship];
    if (terms == null) return null;

    final exactMatch = terms[languageTag];
    if (exactMatch != null) return exactMatch;

    final languageCode = languageTag.split('-').first;
    for (final entry in terms.entries) {
      if (entry.key.split('-').first == languageCode) {
        return entry.value;
      }
    }

    return null;
  }
}
