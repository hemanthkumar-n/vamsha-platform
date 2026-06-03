import 'package:flutter/material.dart';

class FamilyUnitCard extends StatelessWidget {
  final String husband;
  final String wife;

  const FamilyUnitCard({
    super.key,
    required this.husband,
    required this.wife,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue.shade200,
        ),
      ),
      child: Column(
        children: [
          Text(
            husband,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          const SizedBox(height: 4),
          Text(
            wife,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

