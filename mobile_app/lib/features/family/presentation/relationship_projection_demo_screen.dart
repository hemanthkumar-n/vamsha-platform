import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../domain/relationship_projection.dart';
import '../domain/relationship_projection_service.dart';
import '../models/founder_graph.dart';
import '../models/person_entity.dart';

class RelationshipProjectionDemoScreen extends StatefulWidget {
  const RelationshipProjectionDemoScreen({super.key});

  @override
  State<RelationshipProjectionDemoScreen> createState() =>
      _RelationshipProjectionDemoScreenState();
}

class _RelationshipProjectionDemoScreenState
    extends State<RelationshipProjectionDemoScreen> {
  static const _projectionService = RelationshipProjectionService();

  static const _viewers = <_ViewerOption>[
    _ViewerOption(id: 'hemanth', label: 'Hemanth'),
    _ViewerOption(id: 'sudha', label: 'Sudha Rani'),
  ];

  static const _targetsByViewer = <String, List<String>>{
    'hemanth': ['sudha', 'prasad', 'divya', 'keerthi', 'yuvan'],
    'sudha': [
      'subbarao',
      'samarajamma',
      'prasad',
      'hemanth',
      'divya',
      'narendranath',
      'lakshmikanthamma',
    ],
  };

  String _viewerId = 'hemanth';

  @override
  Widget build(BuildContext context) {
    final viewer = _personById(_viewerId);
    final projections = _targetsByViewer[_viewerId]!
        .map(
          (targetId) => _ProjectionRow(
            target: _personById(targetId),
            projection: _projectionService.project(
              viewerId: _viewerId,
              targetId: targetId,
            ),
          ),
        )
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Vamsha Relationship Projection'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ProjectionHeader(
                    viewerName: viewer.primaryName,
                    viewerId: _viewerId,
                    viewers: _viewers,
                    onViewerChanged: (viewerId) {
                      setState(() => _viewerId = viewerId);
                    },
                  ),
                  const SizedBox(height: 20),
                  _ProjectionSummary(
                    viewerName: viewer.primaryName,
                    projectionCount: projections.length,
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth >= 760;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: projections.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isWide ? 2 : 1,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: isWide ? 3.2 : 3.5,
                        ),
                        itemBuilder: (context, index) {
                          final row = projections[index];
                          return ProjectionCard(
                            target: row.target,
                            projection: row.projection,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PersonEntity _personById(String id) {
    return FounderGraph.people.firstWhere((person) => person.id == id);
  }
}

class _ProjectionHeader extends StatelessWidget {
  final String viewerName;
  final String viewerId;
  final List<_ViewerOption> viewers;
  final ValueChanged<String> onViewerChanged;

  const _ProjectionHeader({
    required this.viewerName,
    required this.viewerId,
    required this.viewers,
    required this.onViewerChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Same person. Different viewer. Different relationship.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Viewing as $viewerName. Relationship labels below are projected from this viewer, not stored on the person.',
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.68),
                fontSize: 15,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: viewers.map((viewer) {
                final selected = viewer.id == viewerId;
                return ChoiceChip(
                  label: Text(viewer.label),
                  selected: selected,
                  onSelected: (_) => onViewerChanged(viewer.id),
                  selectedColor: AppColors.primary.withValues(alpha: 0.16),
                  labelStyle: TextStyle(
                    color: selected ? AppColors.primary : Colors.black87,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                  side: BorderSide(
                    color: selected
                        ? AppColors.primary
                        : Colors.black.withValues(alpha: 0.12),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectionSummary extends StatelessWidget {
  final String viewerName;
  final int projectionCount;

  const _ProjectionSummary({
    required this.viewerName,
    required this.projectionCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$projectionCount relationship projections for $viewerName',
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class ProjectionCard extends StatelessWidget {
  final PersonEntity target;
  final RelationshipProjection projection;

  const ProjectionCard({
    super.key,
    required this.target,
    required this.projection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            child: const Icon(Icons.person, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  target.primaryName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Relationship to viewer',
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.52),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                projection.relationship,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (projection.culturalRelationship != null) ...[
                const SizedBox(height: 8),
                CulturalRelationshipBadge(
                  label: projection.culturalRelationship!,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class CulturalRelationshipBadge extends StatelessWidget {
  final String label;

  const CulturalRelationshipBadge({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF7A4F1D),
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _ProjectionRow {
  final PersonEntity target;
  final RelationshipProjection projection;

  const _ProjectionRow({
    required this.target,
    required this.projection,
  });
}

class _ViewerOption {
  final String id;
  final String label;

  const _ViewerOption({
    required this.id,
    required this.label,
  });
}
