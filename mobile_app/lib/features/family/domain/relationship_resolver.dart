import '../domain/identity_claim.dart';
import '../models/founder_identity_claims.dart';

class RelationshipResolver {
  const RelationshipResolver();

  static String? relationshipBetween(
    String viewerId,
    String targetId,
  ) {
    try {
      final claim = FounderIdentityClaims.claims.firstWhere(
        (claim) =>
            claim.claimantIdentityId == viewerId &&
            claim.targetIdentityId == targetId,
      );

      return claim.relationship;
    } catch (_) {
      return null;
    }
  }

  static bool hasRelationship(
    String viewerId,
    String targetId,
  ) {
    return relationshipBetween(
          viewerId,
          targetId,
        ) !=
        null;
  }
}

