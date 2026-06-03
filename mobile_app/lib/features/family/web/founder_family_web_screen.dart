import 'package:flutter/material.dart';
import 'widgets/person_card.dart';
import 'widgets/family_unit_card.dart';

class FounderFamilyWebScreen extends StatelessWidget {
  const FounderFamilyWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vamsha Family Web'),
      ),
      body: InteractiveViewer(
        minScale: 0.3,
        maxScale: 4,
        boundaryMargin: const EdgeInsets.all(1000),
        child: Container(
          width: 2400,
          height: 1600,
          color: const Color(0xFFF7F7F7),
          child: Stack(
            children: [
              // PATERNAL GRANDPARENTS
              const Positioned(
                left: 700,
                top: 40,
                child: FamilyUnitCard(
                  husband: 'Natakam Narendranath',
                  wife: 'Natakam Lakshmikanthamma',
                ),
              ),

              // MATERNAL GRANDPARENTS
              const Positioned(
                left: 1350,
                top: 40,
                child: FamilyUnitCard(
                  husband: 'Mamidi Subbarao',
                  wife: 'Mamidi Samarajamma',
                ),
              ),

              // PARENTS
              const Positioned(
                left: 1020,
                top: 320,
                child: FamilyUnitCard(
                  husband: 'Natakam Malakonda Prasad',
                  wife: 'Mamidi Sudha Rani',
                ),
              ),

              // KEERTHI
              const Positioned(
                left: 650,
                top: 720,
                child: PersonCard(
                  name: 'Keerthi Doguparti',
                  relation: 'Wife',
                ),
              ),

              // HEMANTH (CENTER)
              const Positioned(
                left: 1020,
                top: 650,
                child: PersonCard(
                  name: 'Natakam Hemanth Kumar',
                  relation: 'Founder',
                  isViewer: true,
                ),
              ),

              // DIVYA
              const Positioned(
                left: 1450,
                top: 720,
                child: PersonCard(
                  name: 'Natakam Divya Bharathi',
                  relation: 'Sister',
                ),
              ),

              // KAMESH
              const Positioned(
                left: 1700,
                top: 720,
                child: PersonCard(
                  name: 'Buduri Kamesh',
                  relation: 'Brother-in-law',
                ),
              ),

              // YUVAN
              const Positioned(
                left: 1050,
                top: 1080,
                child: PersonCard(
                  name: 'Natakam Yuvan Simha',
                  relation: 'Son',
                ),
              ),

              // DIVYA CHILDREN
              const Positioned(
                left: 1550,
                top: 1080,
                child: PersonCard(
                  name: 'Buduri Shreasta',
                  relation: 'Niece',
                ),
              ),

              const Positioned(
                left: 1770,
                top: 1080,
                child: PersonCard(
                  name: 'Buduri Vedhansh',
                  relation: 'Nephew',
                ),
              ),

              const Positioned(
                left: 1990,
                top: 1080,
                child: PersonCard(
                  name: 'Buduri Krithiksha',
                  relation: 'Niece',
                ),
              ),

              // SECTION LABELS

              Positioned(
                left: 760,
                top: 10,
                child: _label('Natakam Branch'),
              ),

              Positioned(
                left: 1420,
                top: 10,
                child: _label('Mamidi Branch'),
              ),

              Positioned(
                left: 600,
                top: 640,
                child: _label('Doguparti Family'),
              ),

              Positioned(
                left: 1680,
                top: 640,
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

