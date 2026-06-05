import '../models/family_unit.dart';
import '../models/founder_graph.dart';
import '../models/person_entity.dart';
import 'relationship_projection.dart';

class RelationshipProjectionService {
  const RelationshipProjectionService();

  RelationshipProjection project({
    required String viewerId,
    required String targetId,
  }) {
    final relationship = _relationship(viewerId: viewerId, targetId: targetId);

    return RelationshipProjection(
      viewerId: viewerId,
      targetId: targetId,
      relationship: relationship.label,
      culturalRelationship: relationship.culturalLabel,
    );
  }

  _ProjectedRelationship _relationship({
    required String viewerId,
    required String targetId,
  }) {
    if (viewerId == targetId) {
      return const _ProjectedRelationship('You');
    }

    final target = FounderGraph.personById(targetId);

    if (_isParent(parentId: targetId, childId: viewerId)) {
      return _ProjectedRelationship(_parentLabel(target.gender));
    }

    if (_isParent(parentId: viewerId, childId: targetId)) {
      return _ProjectedRelationship(_childLabel(target.gender));
    }

    if (_areSpouses(viewerId, targetId)) {
      return _ProjectedRelationship(_spouseLabel(target.gender));
    }

    if (_areSiblings(viewerId, targetId)) {
      return _ProjectedRelationship(_siblingLabel(target.gender));
    }

    final viewerParents = _parentIds(viewerId);
    for (final parentId in viewerParents) {
      if (_isParent(parentId: targetId, childId: parentId)) {
        return _ProjectedRelationship(_grandparentLabel(target.gender));
      }

      if (_areSiblings(parentId, targetId)) {
        final parent = FounderGraph.personById(parentId);
        return _ProjectedRelationship(
          _parentSiblingLabel(
            targetGender: target.gender,
            parentGender: parent.gender,
          ),
        );
      }
    }

    for (final siblingId in _siblingIds(viewerId)) {
      if (_isParent(parentId: siblingId, childId: targetId)) {
        return _ProjectedRelationship(_siblingChildLabel(target.gender));
      }

      if (_areSpouses(siblingId, targetId)) {
        return _ProjectedRelationship(_siblingSpouseLabel(target.gender));
      }
    }

    final spouseId = _spouseId(viewerId);
    if (spouseId != null && _isParent(parentId: targetId, childId: spouseId)) {
      return _ProjectedRelationship(
        _parentInLawLabel(target.gender),
        culturalLabel: _parentInLawCulturalLabel(target.gender),
      );
    }

    return const _ProjectedRelationship('Extended family');
  }

  bool _isParent({required String parentId, required String childId}) {
    return FounderGraph.relationships.any(
      (edge) => edge.sourceId == parentId && edge.targetId == childId,
    );
  }

  List<String> _parentIds(String personId) {
    return FounderGraph.relationships
        .where((edge) => edge.targetId == personId)
        .map((edge) => edge.sourceId)
        .toSet()
        .toList();
  }

  bool _areSiblings(String firstId, String secondId) {
    if (firstId == secondId) return false;
    final sharedParents = _parentIds(firstId).toSet().intersection(
          _parentIds(secondId).toSet(),
        );
    return sharedParents.isNotEmpty;
  }

  List<String> _siblingIds(String personId) {
    return FounderGraph.people
        .where((person) => _areSiblings(personId, person.id))
        .map((person) => person.id)
        .toList();
  }

  bool _areSpouses(String firstId, String secondId) {
    return FounderGraph.familyUnits.any(
      (unit) => _unitContains(unit, firstId) && _unitContains(unit, secondId),
    );
  }

  String? _spouseId(String personId) {
    for (final unit in FounderGraph.familyUnits) {
      if (unit.partner1Id == personId) return unit.partner2Id;
      if (unit.partner2Id == personId) return unit.partner1Id;
    }
    return null;
  }

  bool _unitContains(FamilyUnit unit, String personId) {
    return unit.partner1Id == personId || unit.partner2Id == personId;
  }

  String _parentLabel(Gender gender) => switch (gender) {
        Gender.male => 'Father',
        Gender.female => 'Mother',
        Gender.unknown => 'Parent',
      };

  String _childLabel(Gender gender) => switch (gender) {
        Gender.male => 'Son',
        Gender.female => 'Daughter',
        Gender.unknown => 'Child',
      };

  String _spouseLabel(Gender gender) => switch (gender) {
        Gender.male => 'Husband',
        Gender.female => 'Wife',
        Gender.unknown => 'Spouse',
      };

  String _siblingLabel(Gender gender) => switch (gender) {
        Gender.male => 'Brother',
        Gender.female => 'Sister',
        Gender.unknown => 'Sibling',
      };

  String _grandparentLabel(Gender gender) => switch (gender) {
        Gender.male => 'Grandfather',
        Gender.female => 'Grandmother',
        Gender.unknown => 'Grandparent',
      };

  String _parentSiblingLabel({
    required Gender targetGender,
    required Gender parentGender,
  }) {
    final side = switch (parentGender) {
      Gender.male => 'Paternal',
      Gender.female => 'Maternal',
      Gender.unknown => '',
    };
    final relation = switch (targetGender) {
      Gender.male => 'Uncle',
      Gender.female => 'Aunt',
      Gender.unknown => 'Parent sibling',
    };
    return [side, relation].where((part) => part.isNotEmpty).join(' ');
  }

  String _siblingChildLabel(Gender gender) => switch (gender) {
        Gender.male => 'Nephew',
        Gender.female => 'Niece',
        Gender.unknown => 'Sibling child',
      };

  String _siblingSpouseLabel(Gender gender) => switch (gender) {
        Gender.male => 'Brother-in-law',
        Gender.female => 'Sister-in-law',
        Gender.unknown => 'Sibling-in-law',
      };

  String _parentInLawLabel(Gender gender) => switch (gender) {
        Gender.male => 'Father-in-law',
        Gender.female => 'Mother-in-law',
        Gender.unknown => 'Parent-in-law',
      };

  String? _parentInLawCulturalLabel(Gender gender) => switch (gender) {
        Gender.male => 'Mamayya',
        Gender.female => 'Athamma',
        Gender.unknown => null,
      };
}

class _ProjectedRelationship {
  final String label;
  final String? culturalLabel;

  const _ProjectedRelationship(
    this.label, {
    this.culturalLabel,
  });
}
