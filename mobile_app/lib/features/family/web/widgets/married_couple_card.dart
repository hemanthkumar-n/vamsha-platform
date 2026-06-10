import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../models/person_entity.dart';

class MarriedCoupleCard extends StatelessWidget {
  final String partner1Id;
  final String partner1Name;
  final String partner1Relation;
  final String? partner1CulturalRelation;
  final Gender partner1Gender;
  final bool isPartner1Viewer;
  final String partner2Id;
  final String partner2Name;
  final String partner2Relation;
  final String? partner2CulturalRelation;
  final Gender partner2Gender;
  final bool isPartner2Viewer;
  final VoidCallback? onPartner1Tap;
  final VoidCallback? onPartner2Tap;

  const MarriedCoupleCard({
    super.key,
    required this.partner1Id,
    required this.partner1Name,
    required this.partner1Relation,
    this.partner1CulturalRelation,
    required this.partner1Gender,
    required this.isPartner1Viewer,
    required this.partner2Id,
    required this.partner2Name,
    required this.partner2Relation,
    this.partner2CulturalRelation,
    required this.partner2Gender,
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
            gender: partner1Gender,
            isViewer: isPartner1Viewer,
            onTap: onPartner1Tap,
          ),
          const Expanded(child: _MarriageBond()),
          _PartnerCard(
            key: ValueKey('couple-person-$partner2Id'),
            name: partner2Name,
            relation: partner2Relation,
            culturalRelation: partner2CulturalRelation,
            gender: partner2Gender,
            isViewer: isPartner2Viewer,
            onTap: onPartner2Tap,
          ),
        ],
      ),
    );
  }
}

class _PartnerCard extends StatefulWidget {
  final String name;
  final String relation;
  final String? culturalRelation;
  final Gender gender;
  final bool isViewer;
  final VoidCallback? onTap;

  const _PartnerCard({
    super.key,
    required this.name,
    required this.relation,
    this.culturalRelation,
    required this.gender,
    required this.isViewer,
    this.onTap,
  });

  @override
  State<_PartnerCard> createState() => _PartnerCardState();
}

class _PartnerCardState extends State<_PartnerCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.isViewer
        ? AppColors.viewer
        : widget.gender == Gender.female
            ? AppColors.female
            : AppColors.male;
    final surface = widget.isViewer
        ? AppColors.viewerSoft
        : widget.gender == Gender.female
            ? AppColors.femaleSoft
            : AppColors.maleSoft;
    final avatar = widget.isViewer
        ? const Color(0xFFDCEAFF)
        : widget.gender == Gender.female
            ? const Color(0xFFFFE2E8)
            : const Color(0xFFDDEFD8);
    final border = widget.isViewer
        ? const Color(0xFF72A4DE)
        : widget.gender == Gender.female
            ? const Color(0xFFF1CCD5)
            : const Color(0xFFCDDFCA);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final relationshipDescription = [
      if (widget.culturalRelation != null) widget.culturalRelation,
      widget.relation,
    ].join(', ');

    return Semantics(
      button: widget.onTap != null,
      selected: widget.isViewer,
      label: widget.onTap == null
          ? '${widget.name}. $relationshipDescription.'
          : '${widget.name}. $relationshipDescription. Open profile.',
      child: MouseRegion(
        cursor:
            widget.onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration:
              reduceMotion ? Duration.zero : const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(
            0,
            _hovered && !reduceMotion ? -3 : 0,
            0,
          ),
          width: AppDimensions.partnerCardWidth,
          height: AppDimensions.partnerCardHeight,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: border,
              width: widget.isViewer ? 2.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: _hovered ? 16 : 9,
                offset: Offset(0, _hovered ? 7 : 4),
                color: Colors.black.withValues(
                  alpha: _hovered ? 0.11 : 0.07,
                ),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(AppDimensions.radius),
              focusColor: AppColors.focus.withValues(alpha: 0.14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isViewer) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'YOU',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: avatar,
                    foregroundColor: accent,
                    child: Icon(
                      widget.gender == Gender.female
                          ? Icons.person_2
                          : Icons.person,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontSize: 14,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 34,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.culturalRelation != null)
                          Text(
                            widget.culturalRelation!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: accent,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        Text(
                          widget.relation,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.mutedInk,
                            fontSize: widget.culturalRelation == null ? 13 : 11,
                            fontWeight: FontWeight.w500,
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
            const Expanded(child: Divider(color: AppColors.line)),
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.marriage.withValues(alpha: 0.35),
                ),
              ),
              child: const Icon(
                Icons.favorite,
                size: 18,
                color: AppColors.marriage,
              ),
            ),
            const Expanded(child: Divider(color: AppColors.line)),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.femaleSoft,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFF1CCD5)),
          ),
          child: const Text(
            'Married',
            style: TextStyle(
              color: AppColors.marriage,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
