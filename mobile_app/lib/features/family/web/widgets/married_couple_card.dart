import 'package:flutter/material.dart';

class MarriedCoupleCard extends StatelessWidget {
  final String partner1Id;
  final String partner1Name;
  final String partner1Relation;
  final String? partner1CulturalRelation;
  final bool isPartner1Viewer;
  final String partner2Id;
  final String partner2Name;
  final String partner2Relation;
  final String? partner2CulturalRelation;
  final bool isPartner2Viewer;
  final VoidCallback? onPartner1Tap;
  final VoidCallback? onPartner2Tap;

  const MarriedCoupleCard({
    super.key,
    required this.partner1Id,
    required this.partner1Name,
    required this.partner1Relation,
    this.partner1CulturalRelation,
    required this.isPartner1Viewer,
    required this.partner2Id,
    required this.partner2Name,
    required this.partner2Relation,
    this.partner2CulturalRelation,
    required this.isPartner2Viewer,
    this.onPartner1Tap,
    this.onPartner2Tap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _PartnerCard(
            key: ValueKey('couple-person-$partner1Id'),
            name: partner1Name,
            relation: partner1Relation,
            culturalRelation: partner1CulturalRelation,
            isViewer: isPartner1Viewer,
            onTap: onPartner1Tap,
          ),
          const Expanded(
            child: _MarriageBond(),
          ),
          _PartnerCard(
            key: ValueKey('couple-person-$partner2Id'),
            name: partner2Name,
            relation: partner2Relation,
            culturalRelation: partner2CulturalRelation,
            isViewer: isPartner2Viewer,
            onTap: onPartner2Tap,
          ),
        ],
      ),
    );
  }
}

class _PartnerCard extends StatelessWidget {
  final String name;
  final String relation;
  final String? culturalRelation;
  final bool isViewer;
  final VoidCallback? onTap;

  const _PartnerCard({
    super.key,
    required this.name,
    required this.relation,
    this.culturalRelation,
    required this.isViewer,
    this.onTap,
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
            width: 190,
            height: 184,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isViewer ? Colors.blue : Colors.grey.shade300,
                width: isViewer ? 3 : 1,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isViewer) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'YOU',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
                const CircleAvatar(
                  radius: 22,
                  child: Icon(Icons.person),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                SizedBox(
                  height: 34,
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
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      Text(
                        relation,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: culturalRelation == null ? 13 : 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MarriageBond extends StatelessWidget {
  const _MarriageBond();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade500)),
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red.shade200),
              ),
              child: const Icon(
                Icons.favorite,
                size: 19,
                color: Colors.red,
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade500)),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF4F4),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFFFCDD2)),
          ),
          child: const Text(
            'Married',
            style: TextStyle(
              color: Color(0xFFB42318),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
