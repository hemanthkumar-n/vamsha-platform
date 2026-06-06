import 'package:flutter/material.dart';

import '../domain/relationship_projection_service.dart';
import '../models/founder_graph.dart';
import '../models/person_profile_metadata.dart';
import 'family_web_layout.dart';
import 'widgets/family_unit_card.dart';
import 'widgets/generation_section.dart';
import 'widgets/married_couple_card.dart';
import 'widgets/person_card.dart';
import 'widgets/relationship_connector.dart';

class FounderFamilyWebScreen extends StatefulWidget {
  const FounderFamilyWebScreen({super.key});

  @override
  State<FounderFamilyWebScreen> createState() => _FounderFamilyWebScreenState();
}

class _FounderFamilyWebScreenState extends State<FounderFamilyWebScreen>
    with SingleTickerProviderStateMixin {
  static const _layout = FounderFamilyWebLayout.layout;
  static const _projectionService = RelationshipProjectionService();
  static const _viewerIds = [
    'doguparthi_siva_prasad',
    'doguparthi_jayamma',
    'doguparthi_kiran',
    'prasad',
    'sudha',
    'hemanth',
    'keerthi',
    'divya',
    'yuvan',
  ];

  final TransformationController _transformationController =
      TransformationController();

  late final AnimationController _cameraAnimationController;
  Animation<Matrix4>? _cameraAnimation;
  String _viewerId = 'hemanth';
  Size? _viewportSize;

  @override
  void initState() {
    super.initState();
    _cameraAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    )..addListener(() {
        final cameraAnimation = _cameraAnimation;
        if (cameraAnimation != null) {
          _transformationController.value = cameraAnimation.value;
        }
      });
  }

  @override
  void dispose() {
    _cameraAnimationController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(isCompact ? 'Vamsha' : 'Vamsha Family Web'),
        actions: [
          IconButton(
            key: const ValueKey('center-on-viewer'),
            tooltip: 'Center on viewer',
            onPressed: () => _centerOnViewer(animate: true),
            icon: const Icon(Icons.center_focus_strong),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _ViewerToolbar(
            viewerIds: _viewerIds,
            viewerId: _viewerId,
            compactViewerName: _compactViewerName,
            onViewerSelected: _selectViewer,
          ),
          _ViewerContextBanner(viewerId: _viewerId),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final viewportSize = constraints.biggest;
                if (_viewportSize != viewportSize) {
                  _viewportSize = viewportSize;
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => _centerOnViewer(animate: false),
                  );
                }

                return ClipRect(
                  child: InteractiveViewer(
                    key: const ValueKey('family-web-interactive-viewer'),
                    transformationController: _transformationController,
                    constrained: false,
                    alignment: Alignment.topLeft,
                    minScale: 0.2,
                    maxScale: 4,
                    boundaryMargin: const EdgeInsets.all(1000),
                    child: Container(
                      width: _layout.width,
                      height: _layout.height,
                      color: const Color(0xFFF7F7F7),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: FamilyConnectorLayer(
                              width: _layout.width,
                              height: _layout.height,
                              connectors: _layout.connectors,
                            ),
                          ),
                          ..._layout.connectors
                              .whereType<SpouseConnector>()
                              .map(_marriageBadge),
                          ..._layout.generationSections.map(_generationSection),
                          ..._layout.familyUnits.map(_familyUnit),
                          ..._layout.people.map(_personNode),
                          ..._layout.branchLabels.map(_branchLabel),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _centerOnViewer({required bool animate}) {
    final viewportSize = _viewportSize;
    if (!mounted ||
        viewportSize == null ||
        viewportSize.width <= 0 ||
        viewportSize.height <= 0) {
      return;
    }

    final scale = _responsiveScale(viewportSize);
    final focalPoint = _layout.focalPointForViewer(_viewerId);
    final target = Matrix4.identity()
      ..translateByDouble(
        viewportSize.width / 2 - focalPoint.dx * scale,
        viewportSize.height / 2 - focalPoint.dy * scale,
        0,
        1,
      )
      ..scaleByDouble(scale, scale, scale, 1);

    if (!animate) {
      _cameraAnimationController.stop();
      _transformationController.value = target;
      return;
    }

    _cameraAnimation = Matrix4Tween(
      begin: _transformationController.value,
      end: target,
    ).animate(
      CurvedAnimation(
        parent: _cameraAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );
    _cameraAnimationController.forward(from: 0);
  }

  void _selectViewer(String viewerId) {
    if (viewerId == _viewerId) {
      _centerOnViewer(animate: true);
      return;
    }

    setState(() => _viewerId = viewerId);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _centerOnViewer(animate: true),
    );
  }

  double _responsiveScale(Size viewportSize) {
    final shortestSide = viewportSize.shortestSide;
    if (shortestSide < 480) return 0.42;
    if (viewportSize.width < 900) return 0.52;
    if (viewportSize.width < 1400) return 0.62;
    return 0.72;
  }

  String _compactViewerName(String viewerId) {
    final viewer = FounderGraph.personById(viewerId);
    if (viewer.knownAs.isNotEmpty) return viewer.knownAs.first;

    final nameParts = viewer.primaryName.split(' ');
    return nameParts.length > 1 ? nameParts[1] : viewer.primaryName;
  }

  Widget _generationSection(GenerationSectionLayout section) {
    return Positioned(
      left: section.position.dx,
      top: section.position.dy,
      child: GenerationSection(title: section.title),
    );
  }

  Widget _familyUnit(FamilyUnitLayout unit) {
    final familyUnit = FounderGraph.familyUnitById(unit.familyUnitId);
    final partner1 = FounderGraph.personById(familyUnit.partner1Id);
    final partner2 = FounderGraph.personById(familyUnit.partner2Id);
    final partner1Projection = _projectionService.project(
      viewerId: _viewerId,
      targetId: partner1.id,
    );
    final partner2Projection = _projectionService.project(
      viewerId: _viewerId,
      targetId: partner2.id,
    );

    return Positioned(
      left: unit.position.dx,
      top: unit.position.dy,
      child: unit.splitPartners
          ? MarriedCoupleCard(
              key: ValueKey('married-couple-${familyUnit.id}'),
              partner1Id: partner1.id,
              partner1Name: partner1.primaryName,
              partner1Relation: partner1Projection.relationship,
              partner1CulturalRelation: partner1Projection.culturalRelationship,
              isPartner1Viewer: partner1.id == _viewerId,
              onPartner1Tap: _viewerIds.contains(partner1.id)
                  ? () => _selectViewer(partner1.id)
                  : null,
              onPartner1ProfileTap: () => _showPersonProfile(partner1.id),
              partner2Id: partner2.id,
              partner2Name: partner2.primaryName,
              partner2Relation: partner2Projection.relationship,
              partner2CulturalRelation: partner2Projection.culturalRelationship,
              isPartner2Viewer: partner2.id == _viewerId,
              onPartner2Tap: _viewerIds.contains(partner2.id)
                  ? () => _selectViewer(partner2.id)
                  : null,
              onPartner2ProfileTap: () => _showPersonProfile(partner2.id),
            )
          : FamilyUnitCard(
              husband: partner1.primaryName,
              wife: partner2.primaryName,
            ),
    );
  }

  Widget _personNode(PersonNodeLayout node) {
    final person = FounderGraph.personById(node.personId);
    final projection = _projectionService.project(
      viewerId: _viewerId,
      targetId: node.personId,
    );

    return Positioned(
      left: node.position.dx,
      top: node.position.dy,
      child: PersonCard(
        key: ValueKey('person-${node.personId}'),
        name: person.primaryName,
        relation: projection.relationship,
        culturalRelation: projection.culturalRelationship,
        isViewer: node.personId == _viewerId,
        onTap: _viewerIds.contains(node.personId)
            ? () => _selectViewer(node.personId)
            : null,
        onProfileTap: () => _showPersonProfile(node.personId),
      ),
    );
  }

  Future<void> _showPersonProfile(String personId) {
    final person = FounderGraph.personById(personId);
    final projection = _projectionService.project(
      viewerId: _viewerId,
      targetId: personId,
    );

    return showDialog<void>(
      context: context,
      builder: (context) => _PersonProfileDialog(
        personName: person.primaryName,
        aliases: person.aliases,
        callingName: projection.culturalRelationship,
        englishRelationship: projection.relationship,
        motherTongue: person.languageProfile.motherTongueName,
        fluentLanguages: person.languageProfile.fluentLanguageTags
            .map(PersonLanguageProfile.languageName)
            .toSet()
            .join(', '),
        state: person.location.administrativeArea,
        religion: person.culturalProfile.religion,
      ),
    );
  }

  Widget _branchLabel(BranchLabelLayout branch) {
    return Positioned(
      left: branch.position.dx,
      top: branch.position.dy,
      child: _Label(text: branch.label),
    );
  }

  Widget _marriageBadge(SpouseConnector connector) {
    return Positioned(
      left: connector.heart.dx - 34,
      top: connector.heart.dy + 22,
      child: const _MarriageBadge(),
    );
  }
}

class _ViewerToolbar extends StatelessWidget {
  final List<String> viewerIds;
  final String viewerId;
  final String Function(String viewerId) compactViewerName;
  final ValueChanged<String> onViewerSelected;

  const _ViewerToolbar({
    required this.viewerIds,
    required this.viewerId,
    required this.compactViewerName,
    required this.onViewerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: SizedBox(
        width: double.infinity,
        height: 64,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 500;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: isCompact ? 12 : 16),
              child: Row(
                children: [
                  if (!isCompact) ...[
                    const Icon(Icons.visibility_outlined, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Viewing as',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 12),
                  ],
                  for (final candidateId in viewerIds) ...[
                    if (candidateId == viewerId)
                      FilledButton.icon(
                        key: ValueKey('select-viewer-$candidateId'),
                        onPressed: () => onViewerSelected(candidateId),
                        icon: const Icon(Icons.check, size: 18),
                        label: Text(
                          compactViewerName(candidateId),
                          key: const ValueKey('active-viewer-name'),
                        ),
                      )
                    else
                      OutlinedButton(
                        key: ValueKey('select-viewer-$candidateId'),
                        onPressed: () => onViewerSelected(candidateId),
                        child: Text(compactViewerName(candidateId)),
                      ),
                    const SizedBox(width: 8),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ViewerContextBanner extends StatelessWidget {
  final String viewerId;

  const _ViewerContextBanner({required this.viewerId});

  @override
  Widget build(BuildContext context) {
    final viewer = FounderGraph.personById(viewerId);

    return Semantics(
      liveRegion: true,
      label: 'Viewing as ${viewer.primaryName}. Relationship labels updated.',
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 240),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              alignment: Alignment.topCenter,
              child: child,
            ),
          );
        },
        child: Container(
          key: ValueKey('viewer-context-$viewerId'),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: const Color(0xFFE8F5F2),
          child: Row(
            children: [
              const Icon(
                Icons.visibility,
                size: 18,
                color: Color(0xFF087F72),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Viewing as: ',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                        text: viewer.primaryName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            '  •  Mother tongue: ${viewer.languageProfile.motherTongueName}',
                        style: const TextStyle(color: Color(0xFF47635F)),
                      ),
                      const TextSpan(
                        text: '  •  Calling names updated',
                        style: TextStyle(color: Color(0xFF47635F)),
                      ),
                    ],
                  ),
                  key: const ValueKey('viewer-context-text'),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _MarriageBadge extends StatelessWidget {
  const _MarriageBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      padding: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4F4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFCDD2)),
      ),
      child: const Text(
        'Married',
        style: TextStyle(
          color: Color(0xFFB42318),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _PersonProfileDialog extends StatelessWidget {
  final String personName;
  final List<String> aliases;
  final String? callingName;
  final String englishRelationship;
  final String motherTongue;
  final String fluentLanguages;
  final String? state;
  final String? religion;

  const _PersonProfileDialog({
    required this.personName,
    required this.aliases,
    required this.callingName,
    required this.englishRelationship,
    required this.motherTongue,
    required this.fluentLanguages,
    required this.state,
    required this.religion,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(personName),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (aliases.isNotEmpty)
              _ProfileRow(
                label: 'Also known as',
                value: aliases.join(', '),
              ),
            _ProfileRow(
              label: 'You call them',
              value: callingName == null
                  ? englishRelationship
                  : '$callingName · $englishRelationship',
            ),
            _ProfileRow(label: 'Mother tongue', value: motherTongue),
            _ProfileRow(
              label: 'Fluent languages',
              value:
                  fluentLanguages.isEmpty ? 'Not specified' : fluentLanguages,
            ),
            _ProfileRow(label: 'State', value: state ?? 'Not specified'),
            _ProfileRow(
              label: 'Religion',
              value: religion ?? 'Not specified',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 128,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF5F6B69),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
