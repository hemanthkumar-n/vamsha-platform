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

    // =====================================
    // HEMANTH VIEW
    // =====================================

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

    // =====================================
    // SUDHA VIEW
    // =====================================

    if (viewerId == 'sudha') {
      if (targetId == 'subbarao') {
        return RelationshipProjection(
          viewerId: viewerId,
          targetId: targetId,
          relationship: 'Father',
        );
      }

      if (targetId == 'samarajamma') {
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
          relationship: 'Husband',
        );
      }

      if (targetId == 'hemanth') {
        return RelationshipProjection(
          viewerId: viewerId,
          targetId: targetId,
          relationship: 'Son',
        );
      }

      if (targetId == 'divya') {
        return RelationshipProjection(
          viewerId: viewerId,
          targetId: targetId,
          relationship: 'Daughter',
        );
      }

      if (targetId == 'narendranath') {
        return RelationshipProjection(
          viewerId: viewerId,
          targetId: targetId,
          relationship: 'Father-in-law',
          culturalRelationship: 'Mamayya',
        );
      }

      if (targetId == 'lakshmikanthamma') {
        return RelationshipProjection(
          viewerId: viewerId,
          targetId: targetId,
          relationship: 'Mother-in-law',
          culturalRelationship: 'Athamma',
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

