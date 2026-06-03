enum ClaimType {
  parent,
  child,
  sibling,
  spouse,
  alias,
  knownAs,
}

class IdentityClaim {
  final String sourceId;

  final String targetId;

  final ClaimType type;

  final bool verified;

  const IdentityClaim({
    required this.sourceId,
    required this.targetId,
    required this.type,
    this.verified = false,
  });
}
