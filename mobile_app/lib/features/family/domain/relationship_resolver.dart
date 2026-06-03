import 'identity_claim.dart';
import '../models/founder_identity_claims.dart';

class RelationshipResolver {
  const RelationshipResolver();

  static ClaimType? relationshipBetween(
    String sourceId,
    String targetId,
  ) {
    try {
      final claim = FounderIdentityClaims.claims.firstWhere(
        (claim) =>
            claim.sourceId == sourceId &&
            claim.targetId == targetId,
      );

      return claim.type;
    } catch (_) {
      return null;
    }
  }

  static bool hasRelationship(
    String sourceId,
    String targetId,
  ) {
    return relationshipBetween(
          sourceId,
          targetId,
        ) !=
        null;
  }
}
