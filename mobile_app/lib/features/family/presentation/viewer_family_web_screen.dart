import 'package:flutter/material.dart';

class ViewerFamilyWebScreen extends StatelessWidget {
  const ViewerFamilyWebScreen({super.key});

  Widget familyUnit(String title, String subtitle) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF6A5AE0),
            Color(0xFF8677FF),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget childNode(String name) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vamsha Family Web'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 24),

              const Text(
                'Viewing As: Hemanth Kumar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 32),

              familyUnit(
                'Natakam Malakonda Prasad ❤️ Sudharani',
                'Parents of Hemanth & Divya',
              ),

              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      familyUnit(
                        'Hemanth ❤️ Keerthi',
                        'Parents of Yuvan',
                      ),
                      const SizedBox(height: 20),
                      childNode('👦 Yuvan Simha'),
                    ],
                  ),

                  const SizedBox(width: 24),

                  Column(
                    children: [
                      familyUnit(
                        'Divya ❤️ Kamesh',
                        'Sibling Branch',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
