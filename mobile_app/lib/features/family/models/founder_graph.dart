import 'family_unit.dart';
import 'person_entity.dart';
import 'relationship_edge.dart';

class FounderGraph {
  static const people = <PersonEntity>[
    PersonEntity(
      id: 'narendranath',
      gender: Gender.male,
      primaryName: 'Natakam Narendranath',
    ),
    PersonEntity(
      id: 'lakshmikanthamma',
      gender: Gender.female,
      primaryName: 'Natakam Lakshmikanthamma',
    ),
    PersonEntity(
      id: 'mallikarjuna',
      gender: Gender.male,
      primaryName: 'Natakam Mallikarjuna Rao',
    ),
    PersonEntity(
      id: 'akalhya',
      gender: Gender.female,
      primaryName: 'Natakam Akalhya',
    ),
    PersonEntity(
      id: 'sandhya',
      gender: Gender.female,
      primaryName: 'Natakam Sandhya Rani',
    ),
    PersonEntity(
      id: 'usha',
      gender: Gender.female,
      primaryName: 'Natakam Usha Rani',
    ),
    PersonEntity(
      id: 'prasad',
      gender: Gender.male,
      primaryName: 'Natakam Malakonda Prasad',
      aliases: ['N Malakonda Prasad', 'N M Prasad'],
      knownAs: ['Prasad'],
    ),
    PersonEntity(
      id: 'subbarao',
      gender: Gender.male,
      primaryName: 'Mamidi Subbarao',
    ),
    PersonEntity(
      id: 'samarajamma',
      gender: Gender.female,
      primaryName: 'Mamidi Samarajamma',
    ),
    PersonEntity(
      id: 'suresh',
      gender: Gender.male,
      primaryName: 'Mamidi Suresh Kumar',
    ),
    PersonEntity(
      id: 'ramesh',
      gender: Gender.male,
      primaryName: 'Mamidi Ramesh Babu',
    ),
    PersonEntity(
      id: 'sudha',
      gender: Gender.female,
      primaryName: 'Natakam Sudha Rani',
      aliases: ['Mamidi Sudha Rani'],
      knownAs: ['Sudha'],
    ),
    PersonEntity(
      id: 'radha',
      gender: Gender.female,
      primaryName: 'Mamidi Radha Rani',
    ),
    PersonEntity(
      id: 'ganesh',
      gender: Gender.male,
      primaryName: 'Mamidi Ganesh Kumar',
    ),
    PersonEntity(
      id: 'hemanth',
      gender: Gender.male,
      primaryName: 'Natakam Hemanth Kumar',
    ),
    PersonEntity(
      id: 'keerthi',
      gender: Gender.female,
      primaryName: 'Doguparthi Keerthi',
      aliases: ['Keerthi Doguparti', 'Keerthi Doguparthi'],
      knownAs: ['Keerthi'],
    ),
    PersonEntity(
      id: 'doguparthi_siva_prasad',
      gender: Gender.male,
      primaryName: 'Doguparthi Siva Prasad',
      knownAs: ['Siva Prasad'],
    ),
    PersonEntity(
      id: 'doguparthi_jayamma',
      gender: Gender.female,
      primaryName: 'Doguparthi Jayamma',
      knownAs: ['Jayamma'],
    ),
    PersonEntity(
      id: 'doguparthi_kiran',
      gender: Gender.male,
      primaryName: 'Doguparthi Kiran Kumar',
      knownAs: ['Kiran'],
    ),
    PersonEntity(
      id: 'divya',
      gender: Gender.female,
      primaryName: 'Natakam Divya Bharathi',
    ),
    PersonEntity(
      id: 'kamesh',
      gender: Gender.male,
      primaryName: 'Buduri Kamesh',
    ),
    PersonEntity(
      id: 'yuvan',
      gender: Gender.male,
      primaryName: 'Natakam Yuvan Simha',
    ),
    PersonEntity(
      id: 'shreasta',
      gender: Gender.female,
      primaryName: 'Buduri Shreasta',
    ),
    PersonEntity(
      id: 'vedhansh',
      gender: Gender.male,
      primaryName: 'Buduri Vedhansh',
    ),
    PersonEntity(
      id: 'krithiksha',
      gender: Gender.female,
      primaryName: 'Buduri Krithiksha',
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
}
