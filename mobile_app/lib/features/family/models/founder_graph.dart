import 'person_entity.dart';
import 'relationship_edge.dart';
import 'family_unit.dart';

class FounderGraph {
  static final people = <PersonEntity>[
    const PersonEntity(
      id: 'narendranath',
      primaryName: 'Natakam Narendranath',
    ),
    const PersonEntity(
      id: 'lakshmikanthamma',
      primaryName: 'Lakshmikanthamma',
    ),
    const PersonEntity(
      id: 'subbarao',
      primaryName: 'Mamidi Subbarao',
    ),
    const PersonEntity(
      id: 'samarajamma',
      primaryName: 'Samarajamma',
    ),
    const PersonEntity(
      id: 'prasad',
      primaryName: 'Natakam Malakonda Prasad',
      aliases: [
        'N Malakonda Prasad',
        'N M Prasad',
      ],
      knownAs: [
        'Prasad',
      ],
    ),
    const PersonEntity(
      id: 'sudha',
      primaryName: 'Natakam Sudha Rani',
      aliases: [
        'Mamidi Sudha Rani',
      ],
      knownAs: [
        'Sudha',
      ],
    ),
    const PersonEntity(
      id: 'hemanth',
      primaryName: 'Natakam Hemanth Kumar',
    ),
    const PersonEntity(
      id: 'keerthi',
      primaryName: 'Keerthi Doguparti',
    ),
    const PersonEntity(
      id: 'divya',
      primaryName: 'Natakam Divya Bharathi',
    ),
    const PersonEntity(
      id: 'kamesh',
      primaryName: 'Buduri Kamesh',
    ),
    const PersonEntity(
      id: 'yuvan',
      primaryName: 'Natakam Yuvan Simha',
    ),
  ];

  static final familyUnits = <FamilyUnit>[
    const FamilyUnit(
      id: 'fu_natakam_root',
      partner1Id: 'narendranath',
      partner2Id: 'lakshmikanthamma',
    ),
    const FamilyUnit(
      id: 'fu_mamidi_root',
      partner1Id: 'subbarao',
      partner2Id: 'samarajamma',
    ),
    const FamilyUnit(
      id: 'fu_prasad_sudha',
      partner1Id: 'prasad',
      partner2Id: 'sudha',
    ),
    const FamilyUnit(
      id: 'fu_hemanth_keerthi',
      partner1Id: 'hemanth',
      partner2Id: 'keerthi',
    ),
    const FamilyUnit(
      id: 'fu_divya_kamesh',
      partner1Id: 'divya',
      partner2Id: 'kamesh',
    ),
  ];

  static final relationships = <RelationshipEdge>[
    const RelationshipEdge(
      sourceId: 'prasad',
      targetId: 'hemanth',
      type: RelationshipType.parent,
    ),
    const RelationshipEdge(
      sourceId: 'sudha',
      targetId: 'hemanth',
      type: RelationshipType.parent,
    ),
    const RelationshipEdge(
      sourceId: 'hemanth',
      targetId: 'yuvan',
      type: RelationshipType.parent,
    ),
  ];
}
