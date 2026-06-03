import 'package:flutter/material.dart';

import 'family_web_layout.dart';
import 'widgets/family_unit_card.dart';
import 'widgets/generation_section.dart';
import 'widgets/person_card.dart';
import 'widgets/relationship_connector.dart';

class FounderFamilyWebScreen extends StatelessWidget {
  const FounderFamilyWebScreen({super.key});

  static const _layout = FounderFamilyWebLayout.layout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vamsha Family Web'),
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
    return Positioned(
      left: unit.position.dx,
      top: unit.position.dy,
      child: FamilyUnitCard(
        husband: unit.husband,
        wife: unit.wife,
      ),
    );
  }

  Widget _personNode(PersonNodeLayout person) {
    return Positioned(
      left: person.position.dx,
      top: person.position.dy,
      child: PersonCard(
        name: person.name,
        relation: person.relation,
        isViewer: person.isViewer,
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
