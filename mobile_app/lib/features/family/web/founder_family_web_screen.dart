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
        child: SizedBox(
          width: 2200,
          height: 1400,
          child: Stack(
            children: [
              Positioned(
                left: 900,
                top: 40,
                child: FamilyUnitCard(
                  husband: 'Natakam Narendranath',
                  wife: 'Lakshmikanthamma',
                ),
              ),

              Positioned(
                left: 1400,
                top: 40,
                child: FamilyUnitCard(
                  husband: 'Mamidi Subbarao',
                  wife: 'Samarajamma',
                ),
              ),

              Positioned(
                left: 1050,
                top: 320,
                child: FamilyUnitCard(
                  husband: 'Malakonda Prasad',
                  wife: 'Sudha Rani',
                ),
              ),

              Positioned(
                left: 650,
                top: 650,
                child: PersonCard(
                  name: 'Keerthi',
                  relation: 'Wife',
                ),
              ),

              Positioned(
                left: 1050,
                top: 650,
                child: PersonCard(
                  name: 'Natakam Hemanth Kumar',
                  relation: 'YOU',
                ),
              ),

              Positioned(
                left: 1400,
                top: 650,
                child: PersonCard(
                  name: 'Divya Bharathi',
                  relation: 'Sister',
                ),
              ),

              Positioned(
                left: 1650,
                top: 650,
                child: PersonCard(
                  name: 'Buduri Kamesh',
                  relation: 'Brother-in-law',
                ),
              ),

              Positioned(
                left: 1050,
                top: 1000,
                child: PersonCard(
                  name: 'Yuvan Simha',
                  relation: 'Son',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

