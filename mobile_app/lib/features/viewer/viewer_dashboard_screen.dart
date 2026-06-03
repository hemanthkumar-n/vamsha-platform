import 'package:flutter/material.dart';

import 'viewer_header.dart';
import 'relationship_summary_card.dart';

class ViewerDashboardScreen extends StatelessWidget {
  const ViewerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('Vamsha'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const ViewerHeader(
              viewerName: 'Hemanth Kumar',
            ),

            const SizedBox(height: 24),

            const RelationshipSummaryCard(
              icon: Icons.favorite,
              title: 'Married To',
              name: 'Keerthi Doguparti',
            ),

            const RelationshipSummaryCard(
              icon: Icons.child_care,
              title: 'Child',
              name: 'Yuvan Simha',
            ),

            const RelationshipSummaryCard(
              icon: Icons.man,
              title: 'Nanna',
              name: 'Natakam Malakonda Prasad',
            ),

            const RelationshipSummaryCard(
              icon: Icons.woman,
              title: 'Amma',
              name: 'Sudharani',
            ),

            const RelationshipSummaryCard(
              icon: Icons.people,
              title: 'Chelli',
              name: 'Divya Bharathi',
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.account_tree,
                    size: 40,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'View Relationship Tree',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

