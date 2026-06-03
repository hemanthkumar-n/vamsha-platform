enum RelationshipType {
  parent,
  child,
  sibling,
  spouse,
  birthFamily,
  marriageFamily,
}

class RelationshipEdge {
  final String sourceId;
  final String targetId;
  final RelationshipType type;

  const RelationshipEdge({
    required this.sourceId,
    required this.targetId,
    required this.type,
  });
}
