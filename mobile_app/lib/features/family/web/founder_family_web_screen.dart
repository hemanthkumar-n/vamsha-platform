import 'package:flutter/material.dart';
import 'widgets/person_card.dart';
import 'widgets/family_unit_card.dart';
import 'widgets/generation_section.dart';
import 'widgets/relationship_connector.dart';

class FounderFamilyWebScreen extends StatelessWidget {
  const FounderFamilyWebScreen({super.key});

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
          width: 2800,
          height: 1800,
          color: const Color(0xFFF7F7F7),
          child: Stack(
            children: [
              // ==================================================
              // CONNECTOR LAYER
              // ==================================================

              const Positioned.fill(
                child: FamilyConnectorLayer(
                  width: 2800,
                  height: 1800,
                ),
              ),

              // ==================================================
              // VIEWER DISTANCE SECTIONS
              // ==================================================

              const Positioned(
                left: 1050,
                top: 20,
                child: GenerationSection(
                  title: 'Ancestors (+2)',
                ),
              ),

              const Positioned(
                left: 1050,
                top: 280,
                child: GenerationSection(
                  title: 'Parents (+1)',
                ),
              ),

              const Positioned(
                left: 1050,
                top: 620,
                child: GenerationSection(
                  title: 'You (0)',
                ),
              ),

              const Positioned(
                left: 1050,
                top: 1080,
                child: GenerationSection(
                  title: 'Children (-1)',
                ),
              ),

              // ==================================================
              // GRANDPARENTS
              // ==================================================

              const Positioned(
                left: 650,
                top: 100,
                child: FamilyUnitCard(
                  husband: 'Natakam Narendranath',
                  wife: 'Lakshmikanthamma',
                ),
              ),

              const Positioned(
                left: 1450,
                top: 100,
                child: FamilyUnitCard(
                  husband: 'Mamidi Subbarao',
                  wife: 'Samarajamma',
                ),
              ),

              // ==================================================
              // NATAKAM SIBLINGS
              // ==================================================

              const Positioned(
                left: 80,
                top: 380,
                child: PersonCard(
                  name: 'Mallikarjuna Rao',
                  relation: 'Paternal Uncle',
                ),
              ),

              const Positioned(
                left: 300,
                top: 380,
                child: PersonCard(
                  name: 'Akalhya',
                  relation: 'Paternal Aunt',
                ),
              ),

              const Positioned(
                left: 520,
                top: 380,
                child: PersonCard(
                  name: 'Sandhya Rani',
                  relation: 'Paternal Aunt',
                ),
              ),

              const Positioned(
                left: 740,
                top: 380,
                child: PersonCard(
                  name: 'Usha Rani',
                  relation: 'Paternal Aunt',
                ),
              ),

              // ==================================================
              // PARENTS
              // ==================================================

              const Positioned(
                left: 1020,
                top: 350,
                child: FamilyUnitCard(
                  husband: 'Malakonda Prasad',
                  wife: 'Sudha Rani',
                ),
              ),

              // ==================================================
              // MAMIDI SIBLINGS
              // ==================================================

              const Positioned(
                left: 1450,
                top: 380,
                child: PersonCard(
                  name: 'Suresh Kumar',
                  relation: 'Maternal Uncle',
                ),
              ),

              const Positioned(
                left: 1670,
                top: 380,
                child: PersonCard(
                  name: 'Ramesh Babu',
                  relation: 'Maternal Uncle',
                ),
              ),

              const Positioned(
                left: 1890,
                top: 380,
                child: PersonCard(
                  name: 'Radha Rani',
                  relation: 'Maternal Aunt',
                ),
              ),

              const Positioned(
                left: 2110,
                top: 380,
                child: PersonCard(
                  name: 'Ganesh Kumar',
                  relation: 'Maternal Uncle',
                ),
              ),

              // ==================================================
              // YOU LAYER
              // ==================================================

              const Positioned(
                left: 650,
                top: 760,
                child: PersonCard(
                  name: 'Keerthi Doguparti',
                  relation: 'Wife',
                ),
              ),

              const Positioned(
                left: 1050,
                top: 700,
                child: PersonCard(
                  name: 'Natakam Hemanth Kumar',
                  relation: 'Founder',
                  isViewer: true,
                ),
              ),

              const Positioned(
                left: 1450,
                top: 760,
                child: PersonCard(
                  name: 'Divya Bharathi',
                  relation: 'Sister',
                ),
              ),

              const Positioned(
                left: 1700,
                top: 760,
                child: PersonCard(
                  name: 'Buduri Kamesh',
                  relation: 'Brother-in-law',
                ),
              ),

              // ==================================================
              // CHILDREN
              // ==================================================

              const Positioned(
                left: 900,
                top: 1180,
                child: PersonCard(
                  name: 'Yuvan Simha',
                  relation: 'Son',
                ),
              ),

              const Positioned(
                left: 1450,
                top: 1180,
                child: PersonCard(
                  name: 'Shreasta',
                  relation: 'Niece',
                ),
              ),

              const Positioned(
                left: 1670,
                top: 1180,
                child: PersonCard(
                  name: 'Vedhansh',
                  relation: 'Nephew',
                ),
              ),

              const Positioned(
                left: 1890,
                top: 1180,
                child: PersonCard(
                  name: 'Krithiksha',
                  relation: 'Niece',
                ),
              ),

              // ==================================================
              // BRANCH LABELS
              // ==================================================

              Positioned(
                left: 720,
                top: 70,
                child: _label('Natakam Branch'),
              ),

              Positioned(
                left: 1520,
                top: 70,
                child: _label('Mamidi Branch'),
              ),

              Positioned(
                left: 600,
                top: 700,
                child: _label('Doguparti Family'),
              ),

              Positioned(
                left: 1700,
                top: 700,
                child: _label('Buduri Family'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
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
