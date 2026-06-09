import 'family_unit.dart';
import 'person_entity.dart';
import 'person_profile_metadata.dart';
import 'relationship_edge.dart';
import 'viewer_relationship_override.dart';

class FamilyGraphData {
  static const _defaultLanguageProfile = <String, dynamic>{
    'uiLanguageTag': 'en-IN',
    'motherTongueTag': 'te-IN',
    'fluentLanguageTags': ['te-IN'],
  };

  final List<PersonEntity> people;
  final List<FamilyUnit> familyUnits;
  final List<RelationshipEdge> relationships;
  final List<ViewerRelationshipOverride> viewerRelationshipOverrides;

  const FamilyGraphData({
    required this.people,
    required this.familyUnits,
    required this.relationships,
    required this.viewerRelationshipOverrides,
  });

  factory FamilyGraphData.fromJson(Map<String, dynamic> json) {
    final defaultLanguage = Map<String, dynamic>.from(
      (json['defaultLanguageProfile'] as Map?) ?? const <String, dynamic>{},
    );
    return FamilyGraphData(
      people: _list(json['people'])
          .map((person) => _personFromJson(person, defaultLanguage))
          .toList(),
      familyUnits: _list(json['familyUnits']).map(_familyUnitFromJson).toList(),
      relationships:
          _list(json['relationships']).map(_relationshipFromJson).toList(),
      viewerRelationshipOverrides: _list(json['viewerRelationshipOverrides'])
          .map(_overrideFromJson)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'defaultLanguageProfile': _defaultLanguageProfile,
        'people': people.map(_personToJson).toList(),
        'familyUnits': familyUnits.map(_familyUnitToJson).toList(),
        'relationships': relationships.map(_relationshipToJson).toList(),
        'viewerRelationshipOverrides':
            viewerRelationshipOverrides.map(_overrideToJson).toList(),
      };

  static List<Map<String, dynamic>> _list(Object? value) {
    if (value is! List) {
      throw const FormatException('Family graph collection is missing.');
    }
    return value.map((item) => Map<String, dynamic>.from(item as Map)).toList();
  }

  static PersonEntity _personFromJson(
    Map<String, dynamic> json,
    Map<String, dynamic> defaultLanguage,
  ) {
    final language = Map<String, dynamic>.from(
      (json['languageProfile'] as Map?) ?? defaultLanguage,
    );
    final location = Map<String, dynamic>.from(
      (json['location'] as Map?) ?? const {},
    );
    final cultural = Map<String, dynamic>.from(
      (json['culturalProfile'] as Map?) ?? const {},
    );

    return PersonEntity(
      id: json['id'] as String,
      primaryName: json['primaryName'] as String,
      gender: Gender.values.byName((json['gender'] as String?) ?? 'unknown'),
      siblingOrder: json['siblingOrder'] as int?,
      aliases: _strings(json['aliases']),
      knownAs: _strings(json['knownAs']),
      languageProfile: PersonLanguageProfile(
        uiLanguageTag: (language['uiLanguageTag'] as String?) ?? 'en',
        motherTongueTag: (language['motherTongueTag'] as String?) ?? 'und',
        fluentLanguageTags: _strings(language['fluentLanguageTags']),
      ),
      location: PersonLocation(
        countryCode: location['countryCode'] as String?,
        administrativeArea: location['administrativeArea'] as String?,
        locality: location['locality'] as String?,
        nativePlace: location['nativePlace'] as String?,
      ),
      culturalProfile: PersonCulturalProfile(
        religion: cultural['religion'] as String?,
      ),
    );
  }

  static Map<String, dynamic> _personToJson(PersonEntity person) {
    final language = {
      'uiLanguageTag': person.languageProfile.uiLanguageTag,
      'motherTongueTag': person.languageProfile.motherTongueTag,
      'fluentLanguageTags': person.languageProfile.fluentLanguageTags,
    };
    final usesDefaultLanguage =
        language['uiLanguageTag'] == _defaultLanguageProfile['uiLanguageTag'] &&
            language['motherTongueTag'] ==
                _defaultLanguageProfile['motherTongueTag'] &&
            _sameStrings(
              language['fluentLanguageTags']! as List<String>,
              _defaultLanguageProfile['fluentLanguageTags']! as List<String>,
            );

    return {
      'id': person.id,
      'primaryName': person.primaryName,
      'gender': person.gender.name,
      if (person.siblingOrder != null) 'siblingOrder': person.siblingOrder,
      if (person.aliases.isNotEmpty) 'aliases': person.aliases,
      if (person.knownAs.isNotEmpty) 'knownAs': person.knownAs,
      if (!usesDefaultLanguage) 'languageProfile': language,
      if (person.location.countryCode != null ||
          person.location.administrativeArea != null ||
          person.location.locality != null ||
          person.location.nativePlace != null)
        'location': {
          if (person.location.countryCode != null)
            'countryCode': person.location.countryCode,
          if (person.location.administrativeArea != null)
            'administrativeArea': person.location.administrativeArea,
          if (person.location.locality != null)
            'locality': person.location.locality,
          if (person.location.nativePlace != null)
            'nativePlace': person.location.nativePlace,
        },
      if (person.culturalProfile.religion != null)
        'culturalProfile': {
          if (person.culturalProfile.religion != null)
            'religion': person.culturalProfile.religion,
        },
    };
  }

  static FamilyUnit _familyUnitFromJson(Map<String, dynamic> json) {
    return FamilyUnit(
      id: json['id'] as String,
      partner1Id: json['partner1Id'] as String,
      partner2Id: json['partner2Id'] as String,
    );
  }

  static Map<String, dynamic> _familyUnitToJson(FamilyUnit unit) => {
        'id': unit.id,
        'partner1Id': unit.partner1Id,
        'partner2Id': unit.partner2Id,
      };

  static RelationshipEdge _relationshipFromJson(Map<String, dynamic> json) {
    return RelationshipEdge(
      sourceId: json['sourceId'] as String,
      targetId: json['targetId'] as String,
      type: RelationshipType.values.byName(json['type'] as String),
    );
  }

  static Map<String, dynamic> _relationshipToJson(RelationshipEdge edge) => {
        'sourceId': edge.sourceId,
        'targetId': edge.targetId,
        'type': edge.type.name,
      };

  static ViewerRelationshipOverride _overrideFromJson(
    Map<String, dynamic> json,
  ) {
    return ViewerRelationshipOverride(
      viewerId: json['viewerId'] as String,
      targetId: json['targetId'] as String,
      canonicalRelationship: json['canonicalRelationship'] as String,
      relationship: json['relationship'] as String,
      culturalRelationship: json['culturalRelationship'] as String?,
    );
  }

  static Map<String, dynamic> _overrideToJson(
    ViewerRelationshipOverride override,
  ) =>
      {
        'viewerId': override.viewerId,
        'targetId': override.targetId,
        'canonicalRelationship': override.canonicalRelationship,
        'relationship': override.relationship,
        if (override.culturalRelationship != null)
          'culturalRelationship': override.culturalRelationship,
      };

  static List<String> _strings(Object? value) {
    return (value as List?)?.cast<String>().toList() ?? const [];
  }

  static bool _sameStrings(List<String> first, List<String> second) {
    if (first.length != second.length) return false;
    for (var index = 0; index < first.length; index++) {
      if (first[index] != second[index]) return false;
    }
    return true;
  }
}
