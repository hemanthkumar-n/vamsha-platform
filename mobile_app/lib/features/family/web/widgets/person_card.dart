import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final String relation;
  final bool isViewer;

  const PersonCard({
    super.key,
    required this.name,
    required this.relation,
    this.isViewer = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isViewer ? 260 : 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isViewer ? Colors.blue : Colors.grey.shade300,
          width: isViewer ? 3 : 1,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        children: [
          if (isViewer)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'YOU',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          const SizedBox(height: 12),

          CircleAvatar(
            radius: isViewer ? 42 : 24,
            child: const Icon(Icons.person),
          ),

          const SizedBox(height: 12),

          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isViewer ? 22 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            relation,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

