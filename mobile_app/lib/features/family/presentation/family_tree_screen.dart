import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';

class FamilyTreeScreen extends StatelessWidget {
  const FamilyTreeScreen({super.key});

  Widget personNode({
    required String name,
    required String relationship,
    required String knownAs,
    required IconData icon,
    bool center = false,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: center ? 180 : 160,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: center
              ? const LinearGradient(
                  colors: [Colors.deepPurple, Colors.blue],
                )
              : const LinearGradient(
                  colors: [Colors.white, Color(0xFFF7F8FF)],
                ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              blurRadius: 16,
              color: Colors.black12,
            )
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: center ? 28 : 22,
              child: Icon(icon),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: center ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: center ? 16 : 14,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: center
                    ? Colors.white24
                    : Colors.deepPurple.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                relationship,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: center ? Colors.white : Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Known As",
              style: TextStyle(
                fontSize: 10,
                color: center ? Colors.white70 : Colors.grey,
              ),
            ),
            Text(
              knownAs,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: center ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 500.ms).scale(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final graph = Graph()..isTree = true;

    final father = Node.Id('father');
    final mother = Node.Id('mother');
    final center = Node.Id('center');
    final spouse = Node.Id('spouse');
    final child = Node.Id('child');
    final sibling = Node.Id('sibling');
    final siblingSpouse = Node.Id('siblingSpouse');

    graph.addEdge(father, center);
    graph.addEdge(mother, center);
    graph.addEdge(center, spouse);
    graph.addEdge(center, child);
    graph.addEdge(center, sibling);
    graph.addEdge(sibling, siblingSpouse);

    final builder = BuchheimWalkerConfiguration()
      ..siblingSeparation = 70
      ..levelSeparation = 100
      ..subtreeSeparation = 80;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Vamsha Family Graph'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Add Relative'),
        icon: const Icon(Icons.add),
      ),
      body: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(300),
        minScale: 0.4,
        maxScale: 3,
        child: GraphView(
          graph: graph,
          algorithm: BuchheimWalkerAlgorithm(
            builder,
            TreeEdgeRenderer(builder),
          ),
          builder: (Node node) {
            switch (node.key?.value) {
              case 'father':
                return personNode(
                  name: 'Natakam Malakonda Prasad',
                  relationship: 'Father',
                  knownAs: 'Nanna',
                  icon: Icons.man,
                );

              case 'mother':
                return personNode(
                  name: 'Sudharani',
                  relationship: 'Mother',
                  knownAs: 'Amma',
                  icon: Icons.woman,
                );

              case 'center':
                return personNode(
                  name: 'Hemanth Kumar',
                  relationship: 'YOU',
                  knownAs: 'Hemanth',
                  icon: Icons.star,
                  center: true,
                );

              case 'spouse':
                return personNode(
                  name: 'Keerthi Doguparti',
                  relationship: 'Spouse',
                  knownAs: 'Keerthi',
                  icon: Icons.favorite,
                );

              case 'child':
                return personNode(
                  name: 'Yuvan Simha',
                  relationship: 'Son',
                  knownAs: 'Yuvan',
                  icon: Icons.child_care,
                );

              case 'sibling':
                return personNode(
                  name: 'Divya Bharathi',
                  relationship: 'Younger Sister',
                  knownAs: 'Chelli',
                  icon: Icons.people,
                );

              case 'siblingSpouse':
                return personNode(
                  name: 'Buduri Kamesh',
                  relationship: 'Brother In Law',
                  knownAs: 'Kamesh Bava',
                  icon: Icons.favorite,
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
