import 'family_unit.dart';
import 'person_entity.dart';
import 'person_profile_metadata.dart';
import 'relationship_edge.dart';
import 'viewer_relationship_override.dart';

const _teluguLanguageProfile = PersonLanguageProfile(
  uiLanguageTag: 'en-IN',
  motherTongueTag: 'te-IN',
  fluentLanguageTags: ['te-IN'],
);

const _hemanthLanguageProfile = PersonLanguageProfile(
  uiLanguageTag: 'en-IN',
  motherTongueTag: 'te-IN',
  fluentLanguageTags: ['te-IN', 'ta-IN', 'ml-IN', 'en-IN'],
);

class FounderGraph {
  static const people = <PersonEntity>[
    PersonEntity(
      id: 'narendranath',
      gender: Gender.male,
      primaryName: 'Natakam Narendranath',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'lakshmikanthamma',
      gender: Gender.female,
      primaryName: 'Natakam Lakshmikanthamma',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'mallikarjuna',
      gender: Gender.male,
      primaryName: 'Natakam Mallikarjuna Rao',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'akalhya',
      gender: Gender.female,
      primaryName: 'Natakam Akalhya',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'sandhya',
      gender: Gender.female,
      primaryName: 'Natakam Sandhya Rani',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'usha',
      gender: Gender.female,
      primaryName: 'Natakam Usha Rani',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'prasad',
      gender: Gender.male,
      primaryName: 'Natakam Malakonda Prasad',
      aliases: ['N Malakonda Prasad', 'N M Prasad'],
      knownAs: ['Prasad'],
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'subbarao',
      gender: Gender.male,
      primaryName: 'Mamidi Subbarao',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'samarajamma',
      gender: Gender.female,
      primaryName: 'Mamidi Samarajamma',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'suresh',
      gender: Gender.male,
      primaryName: 'Mamidi Suresh Kumar',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'ramesh',
      gender: Gender.male,
      primaryName: 'Mamidi Ramesh Babu',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'sudha',
      gender: Gender.female,
      primaryName: 'Natakam Sudha Rani',
      aliases: ['Mamidi Sudha Rani'],
      knownAs: ['Sudha'],
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'radha',
      gender: Gender.female,
      primaryName: 'Mamidi Radha Rani',
      aliases: ['Dhampuri Radha Rani'],
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'ganesh',
      gender: Gender.male,
      primaryName: 'Mamidi Ganesh Kumar',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'hemanth',
      gender: Gender.male,
      siblingOrder: 1,
      primaryName: 'Natakam Hemanth Kumar',
      languageProfile: _hemanthLanguageProfile,
      location: PersonLocation(countryCode: 'IN'),
    ),
    PersonEntity(
      id: 'keerthi',
      gender: Gender.female,
      primaryName: 'Doguparthi Keerthi',
      aliases: ['Keerthi Doguparti', 'Keerthi Doguparthi'],
      knownAs: ['Keerthi'],
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'doguparthi_siva_prasad',
      gender: Gender.male,
      primaryName: 'Doguparthi Siva Prasad',
      knownAs: ['Siva Prasad'],
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'doguparthi_jayamma',
      gender: Gender.female,
      primaryName: 'Doguparthi Jayamma',
      knownAs: ['Jayamma'],
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'doguparthi_kiran',
      gender: Gender.male,
      primaryName: 'Doguparthi Kiran Kumar',
      knownAs: ['Kiran'],
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'divya',
      gender: Gender.female,
      siblingOrder: 2,
      primaryName: 'Natakam Divya Bharathi',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'kamesh',
      gender: Gender.male,
      primaryName: 'Buduri Kamesh',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'yuvan',
      gender: Gender.male,
      primaryName: 'Natakam Yuvan Simha',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'shreasta',
      gender: Gender.female,
      primaryName: 'Buduri Shreasta',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'vedhansh',
      gender: Gender.male,
      primaryName: 'Buduri Vedhansh',
      languageProfile: _teluguLanguageProfile,
    ),
    PersonEntity(
      id: 'krithiksha',
      gender: Gender.female,
      primaryName: 'Buduri Krithiksha',
      languageProfile: _teluguLanguageProfile,
    ),
  ];

  static const familyUnits = <FamilyUnit>[
    FamilyUnit(
      id: 'fu_natakam_root',
      partner1Id: 'narendranath',
      partner2Id: 'lakshmikanthamma',
    ),
    FamilyUnit(
      id: 'fu_mamidi_root',
      partner1Id: 'subbarao',
      partner2Id: 'samarajamma',
    ),
    FamilyUnit(
      id: 'fu_prasad_sudha',
      partner1Id: 'prasad',
      partner2Id: 'sudha',
    ),
    FamilyUnit(
      id: 'fu_hemanth_keerthi',
      partner1Id: 'hemanth',
      partner2Id: 'keerthi',
    ),
    FamilyUnit(
      id: 'fu_doguparthi_parents',
      partner1Id: 'doguparthi_siva_prasad',
      partner2Id: 'doguparthi_jayamma',
    ),
    FamilyUnit(
      id: 'fu_divya_kamesh',
      partner1Id: 'divya',
      partner2Id: 'kamesh',
    ),
  ];

  static const viewerRelationshipOverrides = <ViewerRelationshipOverride>[
    ViewerRelationshipOverride(
      viewerId: 'hemanth',
      targetId: 'mallikarjuna',
      canonicalRelationship: 'paternal_uncle_fathers_elder_brother',
      relationship: 'Paternal Uncle',
      culturalRelationship: 'Pedhananna',
    ),
    ViewerRelationshipOverride(
      viewerId: 'hemanth',
      targetId: 'akalhya',
      canonicalRelationship: 'paternal_aunt_fathers_sister',
      relationship: 'Paternal Aunt',
      culturalRelationship: 'Pedha Attha',
    ),
    ViewerRelationshipOverride(
      viewerId: 'hemanth',
      targetId: 'usha',
      canonicalRelationship: 'paternal_aunt_fathers_sister',
      relationship: 'Paternal Aunt',
      culturalRelationship: 'Attha',
    ),
    ViewerRelationshipOverride(
      viewerId: 'hemanth',
      targetId: 'radha',
      canonicalRelationship: 'maternal_aunt_mothers_younger_sister',
      relationship: 'Maternal Aunt',
      culturalRelationship: 'Pinni',
    ),
    ViewerRelationshipOverride(
      viewerId: 'hemanth',
      targetId: 'divya',
      canonicalRelationship: 'younger_sister',
      relationship: 'Sister',
      culturalRelationship: 'Chelli',
    ),
    ViewerRelationshipOverride(
      viewerId: 'hemanth',
      targetId: 'kamesh',
      canonicalRelationship: 'brother_in_law_sisters_husband',
      relationship: 'Brother-in-law',
      culturalRelationship: 'Bava',
    ),
    ViewerRelationshipOverride(
      viewerId: 'hemanth',
      targetId: 'shreasta',
      canonicalRelationship: 'niece',
      relationship: 'Niece',
      culturalRelationship: 'Kodalu',
    ),
    ViewerRelationshipOverride(
      viewerId: 'hemanth',
      targetId: 'vedhansh',
      canonicalRelationship: 'nephew',
      relationship: 'Nephew',
      culturalRelationship: 'Alludu',
    ),
    ViewerRelationshipOverride(
      viewerId: 'hemanth',
      targetId: 'krithiksha',
      canonicalRelationship: 'niece',
      relationship: 'Niece',
      culturalRelationship: 'Kodalu',
    ),
    ViewerRelationshipOverride(
      viewerId: 'doguparthi_jayamma',
      targetId: 'divya',
      canonicalRelationship: 'daughter_in_law',
      relationship: 'Daughter-in-law',
      culturalRelationship: 'Kodalu',
    ),
    ViewerRelationshipOverride(
      viewerId: 'doguparthi_jayamma',
      targetId: 'kamesh',
      canonicalRelationship: 'son',
      relationship: 'Son',
      culturalRelationship: 'Koduku',
    ),
    ViewerRelationshipOverride(
      viewerId: 'doguparthi_jayamma',
      targetId: 'shreasta',
      canonicalRelationship: 'granddaughter',
      relationship: 'Granddaughter',
      culturalRelationship: 'Kodalu',
    ),
    ViewerRelationshipOverride(
      viewerId: 'doguparthi_jayamma',
      targetId: 'vedhansh',
      canonicalRelationship: 'grandson',
      relationship: 'Grandson',
      culturalRelationship: 'Alludu',
    ),
    ViewerRelationshipOverride(
      viewerId: 'doguparthi_jayamma',
      targetId: 'krithiksha',
      canonicalRelationship: 'granddaughter',
      relationship: 'Granddaughter',
      culturalRelationship: 'Kodalu',
    ),
  ];

  static const relationships = <RelationshipEdge>[
    RelationshipEdge(
        sourceId: 'narendranath',
        targetId: 'mallikarjuna',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'lakshmikanthamma',
        targetId: 'mallikarjuna',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'narendranath',
        targetId: 'akalhya',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'lakshmikanthamma',
        targetId: 'akalhya',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'narendranath',
        targetId: 'sandhya',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'lakshmikanthamma',
        targetId: 'sandhya',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'narendranath',
        targetId: 'usha',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'lakshmikanthamma',
        targetId: 'usha',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'narendranath',
        targetId: 'prasad',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'lakshmikanthamma',
        targetId: 'prasad',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'subbarao',
        targetId: 'suresh',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'samarajamma',
        targetId: 'suresh',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'subbarao',
        targetId: 'ramesh',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'samarajamma',
        targetId: 'ramesh',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'subbarao', targetId: 'sudha', type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'samarajamma',
        targetId: 'sudha',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'subbarao', targetId: 'radha', type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'samarajamma',
        targetId: 'radha',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'subbarao',
        targetId: 'ganesh',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'samarajamma',
        targetId: 'ganesh',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'prasad', targetId: 'hemanth', type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'sudha', targetId: 'hemanth', type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'prasad', targetId: 'divya', type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'sudha', targetId: 'divya', type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'hemanth', targetId: 'yuvan', type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'keerthi', targetId: 'yuvan', type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'doguparthi_siva_prasad',
        targetId: 'keerthi',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'doguparthi_jayamma',
        targetId: 'keerthi',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'doguparthi_siva_prasad',
        targetId: 'doguparthi_kiran',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'doguparthi_jayamma',
        targetId: 'doguparthi_kiran',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'divya', targetId: 'shreasta', type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'kamesh',
        targetId: 'shreasta',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'divya', targetId: 'vedhansh', type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'kamesh',
        targetId: 'vedhansh',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'divya',
        targetId: 'krithiksha',
        type: RelationshipType.parent),
    RelationshipEdge(
        sourceId: 'kamesh',
        targetId: 'krithiksha',
        type: RelationshipType.parent),
  ];

  static PersonEntity personById(String id) {
    return people.firstWhere((person) => person.id == id);
  }

  static FamilyUnit familyUnitById(String id) {
    return familyUnits.firstWhere((unit) => unit.id == id);
  }

  static ViewerRelationshipOverride? relationshipOverride({
    required String viewerId,
    required String targetId,
  }) {
    for (final override in viewerRelationshipOverrides) {
      if (override.viewerId == viewerId && override.targetId == targetId) {
        return override;
      }
    }
    return null;
  }
}
