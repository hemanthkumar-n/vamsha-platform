import 'package:flutter/material.dart';

class FamilyWebLayout {
  final double width;
  final double height;
  final Map<String, Offset> viewerFocalPoints;
  final List<GenerationSectionLayout> generationSections;
  final List<FamilyUnitLayout> familyUnits;
  final List<PersonNodeLayout> people;
  final List<BranchLabelLayout> branchLabels;
  final List<FamilyConnectorSpec> connectors;

  const FamilyWebLayout({
    required this.width,
    required this.height,
    required this.viewerFocalPoints,
    required this.generationSections,
    required this.familyUnits,
    required this.people,
    required this.branchLabels,
    required this.connectors,
  });

  Offset focalPointForViewer(String viewerId) {
    return viewerFocalPoints[viewerId] ?? Offset(width / 2, height / 2);
  }
}

class GenerationSectionLayout {
  final Offset position;
  final String title;

  const GenerationSectionLayout({
    required this.position,
    required this.title,
  });
}

class FamilyUnitLayout {
  final Offset position;
  final String familyUnitId;
  final bool splitPartners;

  const FamilyUnitLayout({
    required this.position,
    required this.familyUnitId,
    this.splitPartners = false,
  });
}

class PersonNodeLayout {
  final Offset position;
  final String personId;
  final bool isViewer;

  const PersonNodeLayout({
    required this.position,
    required this.personId,
    this.isViewer = false,
  });
}

class BranchLabelLayout {
  final Offset position;
  final String label;

  const BranchLabelLayout({
    required this.position,
    required this.label,
  });
}

sealed class FamilyConnectorSpec {
  const FamilyConnectorSpec();
}

class SiblingBranchConnector extends FamilyConnectorSpec {
  final Offset parent;
  final double barY;
  final List<double> childCenters;
  final double childTopY;
  final double? parentChildTopY;

  const SiblingBranchConnector({
    required this.parent,
    required this.barY,
    required this.childCenters,
    required this.childTopY,
    this.parentChildTopY,
  });
}

class FamilyBranchConnector extends FamilyConnectorSpec {
  final Offset from;
  final double barY;
  final List<double> childCenters;
  final double childTopY;
  final double? primaryChildTopY;

  const FamilyBranchConnector({
    required this.from,
    required this.barY,
    required this.childCenters,
    required this.childTopY,
    this.primaryChildTopY,
  });
}

class SpouseConnector extends FamilyConnectorSpec {
  final Offset from;
  final Offset to;
  final Offset heart;

  const SpouseConnector({
    required this.from,
    required this.to,
    required this.heart,
  });
}

class InLawConnector extends FamilyConnectorSpec {
  final Offset from;
  final Offset to;

  const InLawConnector({
    required this.from,
    required this.to,
  });
}

class FounderFamilyWebLayout {
  static const layout = FamilyWebLayout(
    width: 2800,
    height: 1800,
    viewerFocalPoints: {
      'doguparthi_siva_prasad': Offset(175, 800),
      'doguparthi_jayamma': Offset(505, 800),
      'doguparthi_kiran': Offset(340, 1090),
      'prasad': Offset(995, 445),
      'hemanth': Offset(1180, 830),
      'sudha': Offset(1325, 445),
      'keerthi': Offset(780, 850),
      'divya': Offset(1580, 850),
      'yuvan': Offset(1030, 1270),
    },
    generationSections: [
      GenerationSectionLayout(
        position: Offset(1050, 20),
        title: 'Ancestors (+2)',
      ),
      GenerationSectionLayout(
        position: Offset(1050, 280),
        title: 'Parents (+1)',
      ),
      GenerationSectionLayout(
        position: Offset(1050, 620),
        title: 'You (0)',
      ),
      GenerationSectionLayout(
        position: Offset(1050, 1080),
        title: 'Children (-1)',
      ),
    ],
    familyUnits: [
      FamilyUnitLayout(
        position: Offset(530, 100),
        familyUnitId: 'fu_natakam_root',
        splitPartners: true,
      ),
      FamilyUnitLayout(
        position: Offset(1330, 100),
        familyUnitId: 'fu_mamidi_root',
        splitPartners: true,
      ),
      FamilyUnitLayout(
        position: Offset(900, 350),
        familyUnitId: 'fu_prasad_sudha',
        splitPartners: true,
      ),
      FamilyUnitLayout(
        position: Offset(80, 700),
        familyUnitId: 'fu_doguparthi_parents',
        splitPartners: true,
      ),
    ],
    people: [
      PersonNodeLayout(
        position: Offset(80, 380),
        personId: 'mallikarjuna',
      ),
      PersonNodeLayout(
        position: Offset(300, 380),
        personId: 'akalhya',
      ),
      PersonNodeLayout(
        position: Offset(520, 380),
        personId: 'sandhya',
      ),
      PersonNodeLayout(
        position: Offset(740, 380),
        personId: 'usha',
      ),
      PersonNodeLayout(
        position: Offset(1450, 380),
        personId: 'suresh',
      ),
      PersonNodeLayout(
        position: Offset(1670, 380),
        personId: 'ramesh',
      ),
      PersonNodeLayout(
        position: Offset(1890, 380),
        personId: 'radha',
      ),
      PersonNodeLayout(
        position: Offset(2110, 380),
        personId: 'ganesh',
      ),
      PersonNodeLayout(
        position: Offset(650, 760),
        personId: 'keerthi',
      ),
      PersonNodeLayout(
        position: Offset(250, 1000),
        personId: 'doguparthi_kiran',
      ),
      PersonNodeLayout(
        position: Offset(1050, 700),
        personId: 'hemanth',
        isViewer: true,
      ),
      PersonNodeLayout(
        position: Offset(1450, 760),
        personId: 'divya',
      ),
      PersonNodeLayout(
        position: Offset(1700, 760),
        personId: 'kamesh',
      ),
      PersonNodeLayout(
        position: Offset(900, 1180),
        personId: 'yuvan',
      ),
      PersonNodeLayout(
        position: Offset(1450, 1180),
        personId: 'shreasta',
      ),
      PersonNodeLayout(
        position: Offset(1670, 1180),
        personId: 'vedhansh',
      ),
      PersonNodeLayout(
        position: Offset(1890, 1180),
        personId: 'krithiksha',
      ),
    ],
    branchLabels: [
      BranchLabelLayout(
        position: Offset(720, 70),
        label: 'Natakam Branch',
      ),
      BranchLabelLayout(
        position: Offset(1520, 70),
        label: 'Mamidi Branch',
      ),
      BranchLabelLayout(
        position: Offset(235, 660),
        label: 'Doguparthi Family',
      ),
      BranchLabelLayout(
        position: Offset(1700, 700),
        label: 'Buduri Family',
      ),
    ],
    connectors: [
      SiblingBranchConnector(
        parent: Offset(790, 300),
        barY: 330,
        childCenters: [170, 390, 610, 830, 1160],
        childTopY: 380,
        parentChildTopY: 350,
      ),
      SiblingBranchConnector(
        parent: Offset(1590, 300),
        barY: 330,
        childCenters: [1160, 1540, 1760, 1980, 2200],
        childTopY: 380,
        parentChildTopY: 350,
      ),
      FamilyBranchConnector(
        from: Offset(1160, 550),
        barY: 650,
        childCenters: [1180, 1540],
        childTopY: 760,
        primaryChildTopY: 700,
      ),
      FamilyBranchConnector(
        from: Offset(1180, 952),
        barY: 1120,
        childCenters: [990],
        childTopY: 1180,
      ),
      FamilyBranchConnector(
        from: Offset(1660, 910),
        barY: 1120,
        childCenters: [1540, 1760, 1980],
        childTopY: 1180,
      ),
      FamilyBranchConnector(
        from: Offset(340, 900),
        barY: 950,
        childCenters: [340],
        childTopY: 1000,
      ),
      SpouseConnector(
        from: Offset(830, 850),
        to: Offset(1050, 850),
        heart: Offset(940, 850),
      ),
      SpouseConnector(
        from: Offset(1630, 850),
        to: Offset(1700, 850),
        heart: Offset(1665, 850),
      ),
      InLawConnector(
        from: Offset(600, 850),
        to: Offset(650, 850),
      ),
      InLawConnector(
        from: Offset(1740, 700),
        to: Offset(1740, 760),
      ),
    ],
  );
}
