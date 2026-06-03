import 'package:flutter/material.dart';

class FamilyWebLayout {
  final double width;
  final double height;
  final List<GenerationSectionLayout> generationSections;
  final List<FamilyUnitLayout> familyUnits;
  final List<PersonNodeLayout> people;
  final List<BranchLabelLayout> branchLabels;
  final List<FamilyConnectorSpec> connectors;

  const FamilyWebLayout({
    required this.width,
    required this.height,
    required this.generationSections,
    required this.familyUnits,
    required this.people,
    required this.branchLabels,
    required this.connectors,
  });
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
  final String husband;
  final String wife;

  const FamilyUnitLayout({
    required this.position,
    required this.husband,
    required this.wife,
  });
}

class PersonNodeLayout {
  final Offset position;
  final String name;
  final String relation;
  final bool isViewer;

  const PersonNodeLayout({
    required this.position,
    required this.name,
    required this.relation,
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
        position: Offset(650, 100),
        husband: 'Natakam Narendranath',
        wife: 'Lakshmikanthamma',
      ),
      FamilyUnitLayout(
        position: Offset(1450, 100),
        husband: 'Mamidi Subbarao',
        wife: 'Samarajamma',
      ),
      FamilyUnitLayout(
        position: Offset(1020, 350),
        husband: 'Malakonda Prasad',
        wife: 'Sudha Rani',
      ),
    ],
    people: [
      PersonNodeLayout(
        position: Offset(80, 380),
        name: 'Mallikarjuna Rao',
        relation: 'Paternal Uncle',
      ),
      PersonNodeLayout(
        position: Offset(300, 380),
        name: 'Akalhya',
        relation: 'Paternal Aunt',
      ),
      PersonNodeLayout(
        position: Offset(520, 380),
        name: 'Sandhya Rani',
        relation: 'Paternal Aunt',
      ),
      PersonNodeLayout(
        position: Offset(740, 380),
        name: 'Usha Rani',
        relation: 'Paternal Aunt',
      ),
      PersonNodeLayout(
        position: Offset(1450, 380),
        name: 'Suresh Kumar',
        relation: 'Maternal Uncle',
      ),
      PersonNodeLayout(
        position: Offset(1670, 380),
        name: 'Ramesh Babu',
        relation: 'Maternal Uncle',
      ),
      PersonNodeLayout(
        position: Offset(1890, 380),
        name: 'Radha Rani',
        relation: 'Maternal Aunt',
      ),
      PersonNodeLayout(
        position: Offset(2110, 380),
        name: 'Ganesh Kumar',
        relation: 'Maternal Uncle',
      ),
      PersonNodeLayout(
        position: Offset(650, 760),
        name: 'Keerthi Doguparti',
        relation: 'Wife',
      ),
      PersonNodeLayout(
        position: Offset(1050, 700),
        name: 'Natakam Hemanth Kumar',
        relation: 'Founder',
        isViewer: true,
      ),
      PersonNodeLayout(
        position: Offset(1450, 760),
        name: 'Divya Bharathi',
        relation: 'Sister',
      ),
      PersonNodeLayout(
        position: Offset(1700, 760),
        name: 'Buduri Kamesh',
        relation: 'Brother-in-law',
      ),
      PersonNodeLayout(
        position: Offset(900, 1180),
        name: 'Yuvan Simha',
        relation: 'Son',
      ),
      PersonNodeLayout(
        position: Offset(1450, 1180),
        name: 'Shreasta',
        relation: 'Niece',
      ),
      PersonNodeLayout(
        position: Offset(1670, 1180),
        name: 'Vedhansh',
        relation: 'Nephew',
      ),
      PersonNodeLayout(
        position: Offset(1890, 1180),
        name: 'Krithiksha',
        relation: 'Niece',
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
        position: Offset(600, 700),
        label: 'Doguparti Family',
      ),
      BranchLabelLayout(
        position: Offset(1700, 700),
        label: 'Buduri Family',
      ),
    ],
    connectors: [
      SiblingBranchConnector(
        parent: Offset(790, 214),
        barY: 330,
        childCenters: [170, 390, 610, 830, 1160],
        childTopY: 380,
        parentChildTopY: 350,
      ),
      SiblingBranchConnector(
        parent: Offset(1590, 214),
        barY: 330,
        childCenters: [1160, 1540, 1760, 1980, 2200],
        childTopY: 380,
        parentChildTopY: 350,
      ),
      FamilyBranchConnector(
        from: Offset(1160, 464),
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
        from: Offset(720, 700),
        to: Offset(720, 760),
      ),
      InLawConnector(
        from: Offset(1740, 700),
        to: Offset(1740, 760),
      ),
    ],
  );
}
