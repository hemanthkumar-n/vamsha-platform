class RelationshipProjection {
  final String viewerId;

  final String targetId;

  final String relationship;

  final String? culturalRelationship;

  const RelationshipProjection({
    required this.viewerId,
    required this.targetId,
    required this.relationship,
    this.culturalRelationship,
  });
}
