import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final String relation;
  final String? culturalRelation;
  final bool isViewer;
  final VoidCallback? onTap;
  final VoidCallback? onProfileTap;

  const PersonCard({
    super.key,
    required this.name,
    required this.relation,
    this.culturalRelation,
    this.isViewer = false,
    this.onTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: onTap != null,
      selected: isViewer,
      label: onTap == null ? null : 'View family as $name',
      child: MouseRegion(
        cursor: onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Container(
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
            child: Stack(
              children: [
                if (onProfileTap != null)
                  Positioned(
                    right: -8,
                    top: -8,
                    child: IconButton(
                      tooltip: 'View profile',
                      onPressed: onProfileTap,
                      icon: const Icon(Icons.info_outline, size: 18),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                Column(
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
                    SizedBox(
                      height: 38,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (culturalRelation != null)
                            Text(
                              culturalRelation!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFF087F72),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          Text(
                            relation,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: culturalRelation == null ? 14 : 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
