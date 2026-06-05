import 'package:flutter/material.dart';

import '../domain/relationship_projection_service.dart';
import '../models/founder_graph.dart';
import 'family_web_layout.dart';
import 'widgets/family_unit_card.dart';
import 'widgets/generation_section.dart';
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
  static const _viewerIds = ['hemanth', 'sudha'];

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
          Padding(
            padding: EdgeInsets.only(right: isCompact ? 8 : 16),
            child: isCompact
                ? PopupMenuButton<String>(
                    key: const ValueKey('family-web-viewer-menu'),
                    tooltip: 'Change viewer',
                    initialValue: _viewerId,
                    constraints: const BoxConstraints(
                      minWidth: 240,
                      maxWidth: 280,
                    ),
                    onSelected: _selectViewer,
                    itemBuilder: (context) {
                      return _viewerIds.map((viewerId) {
                        return PopupMenuItem(
                          value: viewerId,
                          child: Row(
                            children: [
                              if (viewerId == _viewerId) ...[
                                const Icon(Icons.check, size: 18),
                                const SizedBox(width: 8),
                              ],
                              Text(_compactViewerName(viewerId)),
                            ],
                          ),
                        );
                      }).toList();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.person_outline, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          _compactViewerName(_viewerId),
                          key: const ValueKey('active-viewer-name'),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Viewing as',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 10),
                      SegmentedButton<String>(
                        key: const ValueKey('family-web-viewer-selector'),
                        showSelectedIcon: true,
                        segments: _viewerIds.map((viewerId) {
                          return ButtonSegment(
                            value: viewerId,
                            label: Text(_compactViewerName(viewerId)),
                          );
                        }).toList(),
                        selected: {_viewerId},
                        onSelectionChanged: (selection) {
                          _selectViewer(selection.single);
                        },
                      ),
                    ],
                  ),
          ),
        ],
      ),
      body: LayoutBuilder(
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

    return Positioned(
      left: unit.position.dx,
      top: unit.position.dy,
      child: FamilyUnitCard(
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
        name: person.primaryName,
        relation: projection.relationship,
        isViewer: node.personId == _viewerId,
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
