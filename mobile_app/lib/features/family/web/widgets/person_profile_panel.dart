import 'package:flutter/material.dart';

class PersonProfilePanelData {
  final String personId;
  final String personName;
  final String viewerName;
  final String englishRelationship;
  final String? culturalRelationship;
  final List<String> aliases;
  final List<String> knownAs;
  final String motherTongue;
  final List<String> fluentLanguages;
  final String location;
  final String? religion;
  final List<String> parents;
  final List<String> spouses;
  final List<String> children;
  final bool isViewer;
  final bool canViewFamilyAs;

  const PersonProfilePanelData({
    required this.personId,
    required this.personName,
    required this.viewerName,
    required this.englishRelationship,
    required this.culturalRelationship,
    required this.aliases,
    required this.knownAs,
    required this.motherTongue,
    required this.fluentLanguages,
    required this.location,
    required this.religion,
    required this.parents,
    required this.spouses,
    required this.children,
    required this.isViewer,
    required this.canViewFamilyAs,
  });
}

Future<void> showPersonProfilePanel({
  required BuildContext context,
  required PersonProfilePanelData data,
  VoidCallback? onViewFamilyAs,
}) {
  final compact = MediaQuery.sizeOf(context).width < 700;

  if (compact) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      builder: (sheetContext) => FractionallySizedBox(
        heightFactor: 0.9,
        child: PersonProfilePanel(
          data: data,
          onClose: () => Navigator.of(sheetContext).pop(),
          onViewFamilyAs: onViewFamilyAs == null
              ? null
              : () {
                  Navigator.of(sheetContext).pop();
                  onViewFamilyAs();
                },
        ),
      ),
    );
  }

  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Close person profile',
    barrierColor: Colors.black38,
    transitionDuration: const Duration(milliseconds: 220),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final offset = Tween<Offset>(
        begin: const Offset(0.08, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      );
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(position: offset, child: child),
      );
    },
    pageBuilder: (dialogContext, animation, secondaryAnimation) {
      return SafeArea(
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Material(
              color: Colors.white,
              elevation: 16,
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                key: const ValueKey('person-profile-panel'),
                width: 430,
                height: double.infinity,
                child: PersonProfilePanel(
                  data: data,
                  onClose: () => Navigator.of(dialogContext).pop(),
                  onViewFamilyAs: onViewFamilyAs == null
                      ? null
                      : () {
                          Navigator.of(dialogContext).pop();
                          onViewFamilyAs();
                        },
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class PersonProfilePanel extends StatelessWidget {
  final PersonProfilePanelData data;
  final VoidCallback onClose;
  final VoidCallback? onViewFamilyAs;

  const PersonProfilePanel({
    super.key,
    required this.data,
    required this.onClose,
    required this.onViewFamilyAs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProfileHeader(data: data, onClose: onClose),
        const Divider(height: 1),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
            children: [
              _RelationshipSummary(data: data),
              if (data.knownAs.isNotEmpty || data.aliases.isNotEmpty) ...[
                const SizedBox(height: 28),
                const _SectionTitle(
                  icon: Icons.badge_outlined,
                  title: 'Identity',
                ),
                if (data.knownAs.isNotEmpty)
                  _DetailRow(
                    label: 'Known as',
                    value: data.knownAs.join(', '),
                  ),
                if (data.aliases.isNotEmpty)
                  _DetailRow(
                    label: 'Also known as',
                    value: data.aliases.join(', '),
                  ),
              ],
              const SizedBox(height: 28),
              const _SectionTitle(
                icon: Icons.translate,
                title: 'Language',
              ),
              _DetailRow(
                label: 'Mother tongue',
                value: data.motherTongue,
              ),
              _DetailRow(
                label: 'Fluent languages',
                value: data.fluentLanguages.isEmpty
                    ? 'Not specified'
                    : data.fluentLanguages.join(', '),
              ),
              const SizedBox(height: 28),
              const _SectionTitle(
                icon: Icons.family_restroom_outlined,
                title: 'Immediate family',
              ),
              _FamilyGroup(label: 'Parents', names: data.parents),
              _FamilyGroup(label: 'Spouse', names: data.spouses),
              _FamilyGroup(label: 'Children', names: data.children),
              const SizedBox(height: 28),
              const _SectionTitle(
                icon: Icons.place_outlined,
                title: 'Profile details',
              ),
              _DetailRow(label: 'Location', value: data.location),
              _DetailRow(
                label: 'Religion',
                value: data.religion ?? 'Not specified',
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        _ProfileActions(
          data: data,
          onViewFamilyAs: onViewFamilyAs,
        ),
      ],
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final PersonProfilePanelData data;
  final VoidCallback onClose;

  const _ProfileHeader({
    required this.data,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 12, 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFFE8E0FF),
            foregroundColor: Color(0xFF4F378B),
            child: Icon(Icons.person, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.personName,
                  key: const ValueKey('person-profile-name'),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.isViewer
                      ? 'Current viewer'
                      : 'Viewed from ${data.viewerName}',
                  style: const TextStyle(
                    color: Color(0xFF66706E),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            key: const ValueKey('person-profile-close'),
            tooltip: 'Close profile',
            onPressed: onClose,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

class _RelationshipSummary extends StatelessWidget {
  final PersonProfilePanelData data;

  const _RelationshipSummary({required this.data});

  @override
  Widget build(BuildContext context) {
    final calling = data.culturalRelationship;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5F2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFC5E5DE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.hub_outlined,
            color: Color(0xFF087F72),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Relationship to current viewer',
                  style: TextStyle(
                    color: Color(0xFF47635F),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  calling ?? data.englishRelationship,
                  key: const ValueKey('person-profile-calling-name'),
                  style: const TextStyle(
                    color: Color(0xFF075E54),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (calling != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    data.englishRelationship,
                    style: const TextStyle(color: Color(0xFF47635F)),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionTitle({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 19, color: const Color(0xFF4F378B)),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 124,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF66706E),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilyGroup extends StatelessWidget {
  final String label;
  final List<String> names;

  const _FamilyGroup({
    required this.label,
    required this.names,
  });

  @override
  Widget build(BuildContext context) {
    return _DetailRow(
      label: label,
      value: names.isEmpty ? 'Not recorded' : names.join(', '),
    );
  }
}

class _ProfileActions extends StatelessWidget {
  final PersonProfilePanelData data;
  final VoidCallback? onViewFamilyAs;

  const _ProfileActions({
    required this.data,
    required this.onViewFamilyAs,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isViewer) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.visibility, size: 18, color: Color(0xFF087F72)),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                'You are viewing the family from this person',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF075E54),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (!data.canViewFamilyAs || onViewFamilyAs == null) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Viewer mode for this person will be available as the graph expands.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF66706E)),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          key: ValueKey('profile-view-as-${data.personId}'),
          onPressed: onViewFamilyAs,
          icon: const Icon(Icons.visibility_outlined),
          label: Text('View family as ${_shortName(data.personName)}'),
        ),
      ),
    );
  }

  static String _shortName(String name) {
    final parts = name.split(' ');
    return parts.length > 1 ? parts[1] : name;
  }
}
