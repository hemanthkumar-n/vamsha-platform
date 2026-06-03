import 'person_entity.dart';
import 'relationship_edge.dart';
import 'family_unit.dart';

class FounderGraph {
  static final people = <PersonEntity>[
    PersonEntity(
      id: 'narendranath',
      primaryName: 'Natakam Narendranath',
    ),

    PersonEntity(
      id: 'lakshmikanthamma',
      primaryName: 'Lakshmikanthamma',
    ),

    PersonEntity(
      id: 'subbarao',
      primaryName: 'Mamidi Subbarao',
    ),

    PersonEntity(
      id: 'samarajamma',
      primaryName: 'Samarajamma',
    ),

    PersonEntity(
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

    PersonEntity(
      id: 'sudha',
      primaryName: 'Natakam Sudha Rani',
      aliases: [
        'Mamidi Sudha Rani',
      ],
      knownAs: [
        'Sudha',
      ],
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
  ];

  static final familyUnits = <FamilyUnit>[
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

  static final relationships = <RelationshipEdge>[
    RelationshipEdge(
      sourceId: 'prasad',
      targetId: 'hemanth',
      type: RelationshipType.parent,
    ),

    RelationshipEdge(
      sourceId: 'sudha',
      targetId: 'hemanth',
      type: RelationshipType.parent,
    ),

    RelationshipEdge(
      sourceId: 'hemanth',
      targetId: 'yuvan',
      type: RelationshipType.parent,
    ),
  ];
}