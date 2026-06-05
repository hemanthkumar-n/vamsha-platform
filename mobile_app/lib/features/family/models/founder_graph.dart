import 'family_unit.dart';
import 'person_entity.dart';
import 'relationship_edge.dart';

class FounderGraph {
  static const people = <PersonEntity>[
    PersonEntity(
      id: 'narendranath',
      primaryName: 'Natakam Narendranath',
    ),
    PersonEntity(
      id: 'lakshmikanthamma',
      primaryName: 'Natakam Lakshmikanthamma',
    ),
    PersonEntity(
      id: 'mallikarjuna',
      primaryName: 'Natakam Mallikarjuna Rao',
    ),
    PersonEntity(
      id: 'akalhya',
      primaryName: 'Natakam Akalhya',
    ),
    PersonEntity(
      id: 'sandhya',
      primaryName: 'Natakam Sandhya Rani',
    ),
    PersonEntity(
      id: 'usha',
      primaryName: 'Natakam Usha Rani',
    ),
    PersonEntity(
      id: 'prasad',
      primaryName: 'Natakam Malakonda Prasad',
      aliases: ['N Malakonda Prasad', 'N M Prasad'],
      knownAs: ['Prasad'],
    ),
    PersonEntity(
      id: 'subbarao',
      primaryName: 'Mamidi Subbarao',
    ),
    PersonEntity(
      id: 'samarajamma',
      primaryName: 'Mamidi Samarajamma',
    ),
    PersonEntity(
      id: 'suresh',
      primaryName: 'Mamidi Suresh Kumar',
    ),
    PersonEntity(
      id: 'ramesh',
      primaryName: 'Mamidi Ramesh Babu',
    ),
    PersonEntity(
      id: 'sudha',
      primaryName: 'Natakam Sudha Rani',
      aliases: ['Mamidi Sudha Rani'],
      knownAs: ['Sudha'],
    ),
    PersonEntity(
      id: 'radha',
      primaryName: 'Mamidi Radha Rani',
    ),
    PersonEntity(
      id: 'ganesh',
      primaryName: 'Mamidi Ganesh Kumar',
    ),
    PersonEntity(
      id: 'hemanth',
      primaryName: 'Natakam Hemanth Kumar',
    ),
    PersonEntity(
      id: 'keerthi',
      primaryName: 'Keerthi Doguparti',
    ),
    PersonEntity(
      id: 'divya',
      primaryName: 'Natakam Divya Bharathi',
    ),
    PersonEntity(
      id: 'kamesh',
      primaryName: 'Buduri Kamesh',
    ),
    PersonEntity(
      id: 'yuvan',
      primaryName: 'Natakam Yuvan Simha',
    ),
    PersonEntity(
      id: 'shreasta',
      primaryName: 'Buduri Shreasta',
    ),
    PersonEntity(
      id: 'vedhansh',
      primaryName: 'Buduri Vedhansh',
    ),
    PersonEntity(
      id: 'krithiksha',
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
