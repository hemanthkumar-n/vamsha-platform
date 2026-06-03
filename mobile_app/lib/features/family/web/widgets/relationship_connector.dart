import 'dart:ui' as ui;

import 'package:flutter/material.dart';

enum FamilyConnectorStyle {
  lineage,
  spouse,
  inLaw,
}

class FamilyConnectorLayer extends StatelessWidget {
  final double width;
  final double height;

  const FamilyConnectorLayer({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: Size(width, height),
        painter: _FamilyConnectorPainter(),
      ),
    );
  }
}

class _FamilyConnectorPainter extends CustomPainter {
  static const _lineColor = Color(0xFF263238);
  static const _spouseColor = Color(0xFFEF4444);
  static const _inLawColor = Color(0xFF7C3AED);

  @override
  void paint(Canvas canvas, Size size) {
    final lineagePaint = Paint()
      ..color = _lineColor.withValues(alpha: 0.72)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final spousePaint = Paint()
      ..color = _lineColor.withValues(alpha: 0.72)
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final inLawPaint = Paint()
      ..color = _inLawColor.withValues(alpha: 0.72)
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    _drawSiblingBranch(
      canvas,
      paint: lineagePaint,
      parent: const Offset(790, 214),
      barY: 330,
      childCenters: const [170, 390, 610, 830, 1160],
      childTopY: 380,
      parentChildTopY: 350,
    );

    _drawSiblingBranch(
      canvas,
      paint: lineagePaint,
      parent: const Offset(1590, 214),
      barY: 330,
      childCenters: const [1160, 1540, 1760, 1980, 2200],
      childTopY: 380,
      parentChildTopY: 350,
    );

    _drawFamilyBranch(
      canvas,
      paint: lineagePaint,
      from: const Offset(1160, 464),
      barY: 650,
      childCenters: const [1180, 1540],
      childTopY: 760,
      primaryChildTopY: 700,
    );

    _drawFamilyBranch(
      canvas,
      paint: lineagePaint,
      from: const Offset(1180, 952),
      barY: 1120,
      childCenters: const [990],
      childTopY: 1180,
    );

    _drawFamilyBranch(
      canvas,
      paint: lineagePaint,
      from: const Offset(1660, 910),
      barY: 1120,
      childCenters: const [1540, 1760, 1980],
      childTopY: 1180,
    );

    _drawStraightLine(
      canvas,
      paint: spousePaint,
      from: const Offset(830, 850),
      to: const Offset(1050, 850),
    );
    _drawHeart(canvas, const Offset(940, 850));

    _drawStraightLine(
      canvas,
      paint: spousePaint,
      from: const Offset(1630, 850),
      to: const Offset(1700, 850),
    );
    _drawHeart(canvas, const Offset(1665, 850));

    _drawDashedLine(
      canvas,
      paint: inLawPaint,
      from: const Offset(720, 700),
      to: const Offset(720, 760),
    );
    _drawDashedLine(
      canvas,
      paint: inLawPaint,
      from: const Offset(1740, 700),
      to: const Offset(1740, 760),
    );
  }

  void _drawSiblingBranch(
    Canvas canvas, {
    required Paint paint,
    required Offset parent,
    required double barY,
    required List<double> childCenters,
    required double childTopY,
    double? parentChildTopY,
  }) {
    final minX = childCenters.reduce(
      (value, element) => value < element ? value : element,
    );
    final maxX = childCenters.reduce(
      (value, element) => value > element ? value : element,
    );

    _drawStraightLine(canvas,
        paint: paint, from: parent, to: Offset(parent.dx, barY));
    _drawStraightLine(canvas,
        paint: paint, from: Offset(minX, barY), to: Offset(maxX, barY));

    for (final centerX in childCenters) {
      final topY = centerX == 1160 && parentChildTopY != null
          ? parentChildTopY
          : childTopY;
      _drawStraightLine(
        canvas,
        paint: paint,
        from: Offset(centerX, barY),
        to: Offset(centerX, topY),
      );
    }
  }

  void _drawFamilyBranch(
    Canvas canvas, {
    required Paint paint,
    required Offset from,
    required double barY,
    required List<double> childCenters,
    required double childTopY,
    double? primaryChildTopY,
  }) {
    final minX = childCenters.reduce(
      (value, element) => value < element ? value : element,
    );
    final maxX = childCenters.reduce(
      (value, element) => value > element ? value : element,
    );

    _drawStraightLine(canvas,
        paint: paint, from: from, to: Offset(from.dx, barY));

    if (childCenters.length > 1) {
      _drawStraightLine(canvas,
          paint: paint, from: Offset(minX, barY), to: Offset(maxX, barY));
    }

    for (final centerX in childCenters) {
      final topY = primaryChildTopY != null && centerX == childCenters.first
          ? primaryChildTopY
          : childTopY;
      _drawStraightLine(
        canvas,
        paint: paint,
        from: Offset(centerX, barY),
        to: Offset(centerX, topY),
      );
    }
  }

  void _drawStraightLine(
    Canvas canvas, {
    required Paint paint,
    required Offset from,
    required Offset to,
  }) {
    canvas.drawLine(from, to, paint);
  }

  void _drawDashedLine(
    Canvas canvas, {
    required Paint paint,
    required Offset from,
    required Offset to,
  }) {
    const dashLength = 10.0;
    const gapLength = 7.0;
    final delta = to - from;
    final distance = delta.distance;
    final direction = delta / distance;
    var traveled = 0.0;

    while (traveled < distance) {
      final start = from + direction * traveled;
      final endDistance = (traveled + dashLength).clamp(0.0, distance);
      final end = from + direction * endDistance;
      canvas.drawLine(start, end, paint);
      traveled += dashLength + gapLength;
    }
  }

  void _drawHeart(Canvas canvas, Offset center) {
    final badgePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = _spouseColor.withValues(alpha: 0.32)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, 18, badgePaint);
    canvas.drawCircle(center, 18, borderPaint);

    final paragraphStyle = ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: 18,
      fontFamily: 'Roboto',
    );
    final textStyle = const TextStyle(color: _spouseColor).getTextStyle();
    final builder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText('♥');
    final paragraph = builder.build()
      ..layout(const ui.ParagraphConstraints(width: 36));
    canvas.drawParagraph(paragraph, center.translate(-18, -12));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class VerticalConnector extends StatelessWidget {
  final double height;

  const VerticalConnector({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: height,
      color: Colors.black54,
    );
  }
}

class HorizontalConnector extends StatelessWidget {
  final double width;

  const HorizontalConnector({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 3,
      color: Colors.black54,
    );
  }
}
