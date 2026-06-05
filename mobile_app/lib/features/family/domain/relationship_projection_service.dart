import '../models/family_unit.dart';
import '../models/founder_graph.dart';
import '../models/person_entity.dart';
import 'relationship_projection.dart';
import 'relationship_term_service.dart';

class RelationshipProjectionService {
  final RelationshipTermService termService;

  const RelationshipProjectionService({
    this.termService = const RelationshipTermService(),
  });

  RelationshipProjection project({
    required String viewerId,
    required String targetId,
  }) {
    final relationship = _relationship(viewerId: viewerId, targetId: targetId);
    final viewer = FounderGraph.personById(viewerId);
    final languageTag = viewer.languageProfile.primaryRelationshipLanguageTag;
    final culturalRelationship = termService.termFor(
      canonicalRelationship: relationship.code,
      languageTag: languageTag,
    );

    return RelationshipProjection(
      viewerId: viewerId,
      targetId: targetId,
      canonicalRelationship: relationship.code,
      relationship: relationship.label,
      culturalRelationship: culturalRelationship,
    );
  }

  _ProjectedRelationship _relationship({
    required String viewerId,
    required String targetId,
  }) {
    if (viewerId == targetId) {
      return const _ProjectedRelationship('self', 'You');
    }

    final target = FounderGraph.personById(targetId);

    if (_isParent(parentId: targetId, childId: viewerId)) {
      return _parentRelationship(target.gender);
    }

    if (_isParent(parentId: viewerId, childId: targetId)) {
      return _childRelationship(target.gender);
    }

    if (_areSpouses(viewerId, targetId)) {
      return _spouseRelationship(target.gender);
    }

    if (_areSiblings(viewerId, targetId)) {
      return _siblingRelationship(target.gender);
    }

    final viewerParents = _parentIds(viewerId);
    for (final parentId in viewerParents) {
      if (_isParent(parentId: targetId, childId: parentId)) {
        final parent = FounderGraph.personById(parentId);
        return _grandparentRelationship(
          targetGender: target.gender,
          parentGender: parent.gender,
        );
      }

      if (_areSiblings(parentId, targetId)) {
        final parent = FounderGraph.personById(parentId);
        return _parentSiblingRelationship(
          targetGender: target.gender,
          parentGender: parent.gender,
        );
      }
    }

    for (final siblingId in _siblingIds(viewerId)) {
      if (_isParent(parentId: siblingId, childId: targetId)) {
        return _siblingChildRelationship(target.gender);
      }

      if (_areSpouses(siblingId, targetId)) {
        return _siblingSpouseRelationship(target.gender);
      }
    }

    for (final childId in _childIds(viewerId)) {
      if (_areSpouses(childId, targetId)) {
        return _childInLawRelationship(target.gender);
      }

      if (_isParent(parentId: childId, childId: targetId)) {
        return _grandchildRelationship(target.gender);
      }
    }

    final spouseId = _spouseId(viewerId);
    if (spouseId != null) {
      if (_isParent(parentId: targetId, childId: spouseId)) {
        return _parentInLawRelationship(target.gender);
      }

      if (_areSiblings(spouseId, targetId)) {
        return _siblingSpouseRelationship(target.gender);
      }
    }

    return const _ProjectedRelationship('extended_family', 'Extended family');
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

  List<String> _childIds(String personId) {
    return FounderGraph.relationships
        .where((edge) => edge.sourceId == personId)
        .map((edge) => edge.targetId)
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

  _ProjectedRelationship _parentRelationship(Gender gender) => switch (gender) {
        Gender.male => const _ProjectedRelationship('father', 'Father'),
        Gender.female => const _ProjectedRelationship('mother', 'Mother'),
        Gender.unknown => const _ProjectedRelationship('parent', 'Parent'),
      };

  _ProjectedRelationship _childRelationship(Gender gender) => switch (gender) {
        Gender.male => const _ProjectedRelationship('son', 'Son'),
        Gender.female => const _ProjectedRelationship('daughter', 'Daughter'),
        Gender.unknown => const _ProjectedRelationship('child', 'Child'),
      };

  _ProjectedRelationship _spouseRelationship(Gender gender) => switch (gender) {
        Gender.male => const _ProjectedRelationship('husband', 'Husband'),
        Gender.female => const _ProjectedRelationship('wife', 'Wife'),
        Gender.unknown => const _ProjectedRelationship('spouse', 'Spouse'),
      };

  _ProjectedRelationship _siblingRelationship(Gender gender) =>
      switch (gender) {
        Gender.male => const _ProjectedRelationship('brother', 'Brother'),
        Gender.female => const _ProjectedRelationship('sister', 'Sister'),
        Gender.unknown => const _ProjectedRelationship('sibling', 'Sibling'),
      };

  _ProjectedRelationship _grandparentRelationship({
    required Gender targetGender,
    required Gender parentGender,
  }) {
    final side = switch (parentGender) {
      Gender.male => 'paternal',
      Gender.female => 'maternal',
      Gender.unknown => null,
    };
    final relation = switch (targetGender) {
      Gender.male => 'grandfather',
      Gender.female => 'grandmother',
      Gender.unknown => 'grandparent',
    };
    final label = switch (targetGender) {
      Gender.male => 'Grandfather',
      Gender.female => 'Grandmother',
      Gender.unknown => 'Grandparent',
    };
    return _ProjectedRelationship(
      side == null ? relation : '${relation}_$side',
      label,
    );
  }

  _ProjectedRelationship _parentSiblingRelationship({
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
    return _ProjectedRelationship(
      '${side.toLowerCase()}_${relation.toLowerCase()}'
          .replaceFirst(RegExp('^_'), ''),
      [side, relation].where((part) => part.isNotEmpty).join(' '),
    );
  }

  _ProjectedRelationship _siblingChildRelationship(Gender gender) =>
      switch (gender) {
        Gender.male => const _ProjectedRelationship('nephew', 'Nephew'),
        Gender.female => const _ProjectedRelationship('niece', 'Niece'),
        Gender.unknown =>
          const _ProjectedRelationship('sibling_child', 'Sibling child'),
      };

  _ProjectedRelationship _siblingSpouseRelationship(Gender gender) =>
      switch (gender) {
        Gender.male =>
          const _ProjectedRelationship('brother_in_law', 'Brother-in-law'),
        Gender.female =>
          const _ProjectedRelationship('sister_in_law', 'Sister-in-law'),
        Gender.unknown =>
          const _ProjectedRelationship('sibling_in_law', 'Sibling-in-law'),
      };

  _ProjectedRelationship _childInLawRelationship(Gender gender) =>
      switch (gender) {
        Gender.male => const _ProjectedRelationship('son_in_law', 'Son-in-law'),
        Gender.female =>
          const _ProjectedRelationship('daughter_in_law', 'Daughter-in-law'),
        Gender.unknown =>
          const _ProjectedRelationship('child_in_law', 'Child-in-law'),
      };

  _ProjectedRelationship _grandchildRelationship(Gender gender) =>
      switch (gender) {
        Gender.male => const _ProjectedRelationship('grandson', 'Grandson'),
        Gender.female =>
          const _ProjectedRelationship('granddaughter', 'Granddaughter'),
        Gender.unknown =>
          const _ProjectedRelationship('grandchild', 'Grandchild'),
      };

  _ProjectedRelationship _parentInLawRelationship(Gender gender) =>
      switch (gender) {
        Gender.male =>
          const _ProjectedRelationship('father_in_law', 'Father-in-law'),
        Gender.female =>
          const _ProjectedRelationship('mother_in_law', 'Mother-in-law'),
        Gender.unknown =>
          const _ProjectedRelationship('parent_in_law', 'Parent-in-law'),
      };
}

class _ProjectedRelationship {
  final String code;
  final String label;

  const _ProjectedRelationship(this.code, this.label);
}
