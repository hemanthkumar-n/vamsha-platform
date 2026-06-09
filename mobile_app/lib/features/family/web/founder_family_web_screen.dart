import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../domain/relationship_projection_service.dart';
import '../models/founder_graph.dart';
import '../models/person_profile_metadata.dart';
import '../models/relationship_edge.dart';
import 'family_web_layout.dart';
import 'widgets/family_unit_card.dart';
import 'widgets/generation_section.dart';
import 'widgets/married_couple_card.dart';
import 'widgets/person_card.dart';
import 'widgets/person_profile_panel.dart';
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
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFE7E8E4)),
        ),
        titleSpacing: 16,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.maleSoft,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFCDDFCA)),
              ),
              child: const Icon(
                Icons.family_restroom,
                size: 20,
                color: AppColors.male,
              ),
            ),
            const SizedBox(width: 10),
            Text(isCompact ? 'Vamsha' : 'Vamsha Family Web'),
          ],
        ),
        actions: [
          IconButton(
            key: const ValueKey('zoom-out'),
            tooltip: 'Zoom out',
            onPressed: () => _zoomBy(0.82),
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            key: const ValueKey('zoom-in'),
            tooltip: 'Zoom in',
            onPressed: () => _zoomBy(1.22),
            icon: const Icon(Icons.add),
          ),
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
                      color: AppColors.background,
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

  void _zoomBy(double factor) {
    final viewportSize = _viewportSize;
    if (viewportSize == null) return;

    final viewportCenter = Offset(
      viewportSize.width / 2,
      viewportSize.height / 2,
    );
    final scenePoint = _transformationController.toScene(viewportCenter);
    final currentScale = _transformationController.value.getMaxScaleOnAxis();
    final targetScale = (currentScale * factor).clamp(0.2, 4.0);
    final target = Matrix4.identity()
      ..translateByDouble(
        viewportCenter.dx - scenePoint.dx * targetScale,
        viewportCenter.dy - scenePoint.dy * targetScale,
        0,
        1,
      )
      ..scaleByDouble(targetScale, targetScale, targetScale, 1);

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
              partner1Gender: partner1.gender,
              isPartner1Viewer: partner1.id == _viewerId,
              onPartner1Tap: () => _showPersonProfile(partner1.id),
              partner2Id: partner2.id,
              partner2Name: partner2.primaryName,
              partner2Relation: partner2Projection.relationship,
              partner2CulturalRelation: partner2Projection.culturalRelationship,
              partner2Gender: partner2.gender,
              isPartner2Viewer: partner2.id == _viewerId,
              onPartner2Tap: () => _showPersonProfile(partner2.id),
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
        gender: person.gender,
        isViewer: node.personId == _viewerId,
        onTap: () => _showPersonProfile(node.personId),
      ),
    );
  }

  Future<void> _showPersonProfile(String personId) {
    final person = FounderGraph.personById(personId);
    final viewer = FounderGraph.personById(_viewerId);
    final projection = _projectionService.project(
      viewerId: _viewerId,
      targetId: personId,
    );

    return showPersonProfilePanel(
      context: context,
      data: PersonProfilePanelData(
        personId: person.id,
        personName: person.primaryName,
        viewerName: viewer.primaryName,
        aliases: person.aliases,
        knownAs: person.knownAs,
        culturalRelationship: projection.culturalRelationship,
        englishRelationship: projection.relationship,
        motherTongue: person.languageProfile.motherTongueName,
        fluentLanguages: person.languageProfile.fluentLanguageTags
            .map(PersonLanguageProfile.languageName)
            .toSet()
            .toList(),
        location: _profileLocation(personId),
        religion: person.culturalProfile.religion,
        parents: _parentNames(personId),
        spouses: _spouseNames(personId),
        children: _childNames(personId),
        isViewer: personId == _viewerId,
        canViewFamilyAs: _viewerIds.contains(personId),
      ),
      onViewFamilyAs: _viewerIds.contains(personId) && personId != _viewerId
          ? () => _selectViewer(personId)
          : null,
    );
  }

  List<String> _parentNames(String personId) {
    return FounderGraph.relationships
        .where(
          (edge) =>
              edge.type == RelationshipType.parent && edge.targetId == personId,
        )
        .map((edge) => FounderGraph.personById(edge.sourceId).primaryName)
        .toList();
  }

  List<String> _childNames(String personId) {
    return FounderGraph.relationships
        .where(
          (edge) =>
              edge.type == RelationshipType.parent && edge.sourceId == personId,
        )
        .map((edge) => FounderGraph.personById(edge.targetId).primaryName)
        .toList();
  }

  List<String> _spouseNames(String personId) {
    return FounderGraph.familyUnits
        .where(
          (unit) => unit.partner1Id == personId || unit.partner2Id == personId,
        )
        .map(
          (unit) => FounderGraph.personById(
            unit.partner1Id == personId ? unit.partner2Id : unit.partner1Id,
          ).primaryName,
        )
        .toList();
  }

  String _profileLocation(String personId) {
    final location = FounderGraph.personById(personId).location;
    final values = [
      location.locality,
      location.administrativeArea,
      location.nativePlace,
      if (location.countryCode == 'IN') 'India' else location.countryCode,
    ].whereType<String>().where((value) => value.isNotEmpty).toSet().toList();
    return values.isEmpty ? 'Not specified' : values.join(', ');
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
      color: AppColors.surface,
      child: SizedBox(
        width: double.infinity,
        height: 68,
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
    final isCompact = MediaQuery.sizeOf(context).width < 600;

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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          decoration: const BoxDecoration(
            color: Color(0xFFEEF7F4),
            border: Border(
              bottom: BorderSide(color: Color(0xFFD8E9E4)),
            ),
          ),
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
                  maxLines: isCompact ? 2 : 1,
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
        color: AppColors.maleSoft,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCDDFCA)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.account_tree_outlined,
            size: 15,
            color: AppColors.male,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF315F41),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
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
        color: AppColors.femaleSoft,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFCDD2)),
      ),
      child: const Text(
        'Married',
        style: TextStyle(
          color: AppColors.marriage,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
