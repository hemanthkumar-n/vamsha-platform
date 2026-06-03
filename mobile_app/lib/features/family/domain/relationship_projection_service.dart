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

    // Hemanth-centric projections

    if (viewerId == 'hemanth') {
      if (targetId == 'sudha') {
        return RelationshipProjection(
          viewerId: viewerId,
          targetId: targetId,
          relationship: 'Mother',
        );
      }

      if (targetId == 'prasad') {
        return RelationshipProjection(
          viewerId: viewerId,
          targetId: targetId,
          relationship: 'Father',
        );
      }

      if (targetId == 'divya') {
        return RelationshipProjection(
          viewerId: viewerId,
          targetId: targetId,
          relationship: 'Sister',
        );
      }

      if (targetId == 'keerthi') {
        return RelationshipProjection(
          viewerId: viewerId,
          targetId: targetId,
          relationship: 'Spouse',
        );
      }

      if (targetId == 'yuvan') {
        return RelationshipProjection(
          viewerId: viewerId,
          targetId: targetId,
          relationship: 'Son',
        );
      }
    }

    return RelationshipProjection(
      viewerId: viewerId,
      targetId: targetId,
      relationship: 'Unknown',
    );
  }
}
