import 'package:flutter/material.dart';

class ViewerHeader extends StatelessWidget {
  final String viewerName;

  const ViewerHeader({
    super.key,
    required this.viewerName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Colors.deepPurple,
            Colors.blue,
          ],
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            child: Icon(Icons.person),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Viewing As',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                Text(
                  viewerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
