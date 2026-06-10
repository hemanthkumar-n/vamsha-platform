import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../models/person_entity.dart';

class PersonCard extends StatefulWidget {
  final String name;
  final String relation;
  final String? culturalRelation;
  final Gender gender;
  final bool isViewer;
  final VoidCallback? onTap;

  const PersonCard({
    super.key,
    required this.name,
    required this.relation,
    this.culturalRelation,
    required this.gender,
    this.isViewer = false,
    this.onTap,
  });

  @override
  State<PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = _PersonPalette.forPerson(
      gender: widget.gender,
      isViewer: widget.isViewer,
    );
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
          width: widget.isViewer
              ? AppDimensions.viewerCardWidth
              : AppDimensions.personCardWidth,
          height: widget.isViewer
              ? AppDimensions.viewerCardHeight
              : AppDimensions.personCardHeight,
          padding: EdgeInsets.all(widget.isViewer ? 12 : 10),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: palette.border,
              width: widget.isViewer ? 2.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: _hovered ? 18 : 10,
                offset: Offset(0, _hovered ? 8 : 4),
                color: Colors.black.withValues(
                  alpha: _hovered ? 0.12 : 0.07,
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
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: palette.accent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'YOU',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  CircleAvatar(
                    radius: widget.isViewer ? 38 : 22,
                    backgroundColor: palette.avatar,
                    foregroundColor: palette.accent,
                    child: Icon(
                      widget.gender == Gender.female
                          ? Icons.person_2
                          : Icons.person,
                      size: widget.isViewer ? 40 : 24,
                    ),
                  ),
                  SizedBox(height: widget.isViewer ? 10 : 8),
                  Text(
                    widget.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: widget.isViewer ? 19 : 13,
                      height: 1.16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
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
                              color: palette.accent,
                              fontSize: widget.isViewer ? 14 : 12,
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

class _PersonPalette {
  final Color surface;
  final Color avatar;
  final Color accent;
  final Color border;

  const _PersonPalette({
    required this.surface,
    required this.avatar,
    required this.accent,
    required this.border,
  });

  factory _PersonPalette.forPerson({
    required Gender gender,
    required bool isViewer,
  }) {
    if (isViewer) {
      return const _PersonPalette(
        surface: AppColors.viewerSoft,
        avatar: Color(0xFFDCEAFF),
        accent: AppColors.viewer,
        border: Color(0xFF72A4DE),
      );
    }

    if (gender == Gender.female) {
      return const _PersonPalette(
        surface: AppColors.femaleSoft,
        avatar: Color(0xFFFFE2E8),
        accent: AppColors.female,
        border: Color(0xFFF1CCD5),
      );
    }

    return const _PersonPalette(
      surface: AppColors.maleSoft,
      avatar: Color(0xFFDDEFD8),
      accent: AppColors.male,
      border: Color(0xFFCDDFCA),
    );
  }
}
