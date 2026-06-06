class ViewerRelationshipOverride {
  final String viewerId;
  final String targetId;
  final String canonicalRelationship;
  final String relationship;
  final String? culturalRelationship;

  const ViewerRelationshipOverride({
    required this.viewerId,
    required this.targetId,
    required this.canonicalRelationship,
    required this.relationship,
    this.culturalRelationship,
  });
}
