import 'relationship_projection.dart';

class RelationshipProjectionService {
  const RelationshipProjectionService();

  RelationshipProjection project({
    required String viewerId,
    required String targetId,
  }) {
    if (viewerId == targetId) {
      return RelationshipProjection(
        viewerId: viewerId,
        targetId: targetId,
        relationship: 'You',
      );
    }

    return RelationshipProjection(
      viewerId: viewerId,
      targetId: targetId,
      relationship: 'Unknown',
    );
  }
}
