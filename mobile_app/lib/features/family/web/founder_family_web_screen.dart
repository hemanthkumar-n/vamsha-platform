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

class _FounderFamilyWebScreenState extends State<FounderFamilyWebScreen> {
  static const _layout = FounderFamilyWebLayout.layout;
  static const _projectionService = RelationshipProjectionService();
  static const _viewerIds = ['hemanth', 'sudha'];

  String _viewerId = 'hemanth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vamsha Family Web'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Viewing as',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 10),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    key: const ValueKey('family-web-viewer-selector'),
                    value: _viewerId,
                    borderRadius: BorderRadius.circular(8),
                    items: _viewerIds.map((viewerId) {
                      final viewer = FounderGraph.personById(viewerId);
                      return DropdownMenuItem(
                        value: viewerId,
                        child: Text(viewer.knownAs.isNotEmpty
                            ? viewer.knownAs.first
                            : viewer.primaryName),
                      );
                    }).toList(),
                    onChanged: (viewerId) {
                      if (viewerId == null) return;
                      setState(() => _viewerId = viewerId);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: InteractiveViewer(
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
