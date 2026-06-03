import 'package:flutter/material.dart';
import '../domain/relationship_resolver.dart';

class VRIDemoScreen extends StatelessWidget {
  const VRIDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final father = RelationshipResolver.relationshipBetween(
      'hemanth',
      'prasad',
    );

    final sister = RelationshipResolver.relationshipBetween(
      'hemanth',
      'divya',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('VRI Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Relationship Intelligence',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const Text('Hemanth → Prasad'),
            Text('Relationship: $father'),
            const SizedBox(height: 20),
            const Text('Hemanth → Divya'),
            Text('Relationship: $sister'),
          ],
        ),
      ),
    );
  }
}
