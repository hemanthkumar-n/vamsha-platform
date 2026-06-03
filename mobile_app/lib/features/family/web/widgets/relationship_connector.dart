import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../family_web_layout.dart';

class FamilyConnectorLayer extends StatelessWidget {
  final double width;
  final double height;
  final List<FamilyConnectorSpec> connectors;

  const FamilyConnectorLayer({
    super.key,
    required this.width,
    required this.height,
    required this.connectors,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: Size(width, height),
        painter: _FamilyConnectorPainter(connectors),
      ),
    );
  }
}

class _FamilyConnectorPainter extends CustomPainter {
  final List<FamilyConnectorSpec> connectors;

  static const _lineColor = Color(0xFF263238);
  static const _spouseColor = Color(0xFFEF4444);
  static const _inLawColor = Color(0xFF7C3AED);

  const _FamilyConnectorPainter(this.connectors);

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

    for (final connector in connectors) {
      switch (connector) {
        case SiblingBranchConnector():
          _drawSiblingBranch(canvas, paint: lineagePaint, connector: connector);
        case FamilyBranchConnector():
          _drawFamilyBranch(canvas, paint: lineagePaint, connector: connector);
        case SpouseConnector():
          _drawStraightLine(
            canvas,
            paint: spousePaint,
            from: connector.from,
            to: connector.to,
          );
          _drawHeart(canvas, connector.heart);
        case InLawConnector():
          _drawDashedLine(
            canvas,
            paint: inLawPaint,
            from: connector.from,
            to: connector.to,
          );
      }
    }
  }

  void _drawSiblingBranch(
    Canvas canvas, {
    required Paint paint,
    required SiblingBranchConnector connector,
  }) {
    final minX = connector.childCenters.reduce(
      (value, element) => value < element ? value : element,
    );
    final maxX = connector.childCenters.reduce(
      (value, element) => value > element ? value : element,
    );

    _drawStraightLine(
      canvas,
      paint: paint,
      from: connector.parent,
      to: Offset(connector.parent.dx, connector.barY),
    );
    _drawStraightLine(
      canvas,
      paint: paint,
      from: Offset(minX, connector.barY),
      to: Offset(maxX, connector.barY),
    );

    for (final centerX in connector.childCenters) {
      final topY = centerX == 1160 && connector.parentChildTopY != null
          ? connector.parentChildTopY!
          : connector.childTopY;
      _drawStraightLine(
        canvas,
        paint: paint,
        from: Offset(centerX, connector.barY),
        to: Offset(centerX, topY),
      );
    }
  }

  void _drawFamilyBranch(
    Canvas canvas, {
    required Paint paint,
    required FamilyBranchConnector connector,
  }) {
    final minX = connector.childCenters.reduce(
      (value, element) => value < element ? value : element,
    );
    final maxX = connector.childCenters.reduce(
      (value, element) => value > element ? value : element,
    );

    _drawStraightLine(
      canvas,
      paint: paint,
      from: connector.from,
      to: Offset(connector.from.dx, connector.barY),
    );

    if (connector.childCenters.length > 1) {
      _drawStraightLine(
        canvas,
        paint: paint,
        from: Offset(minX, connector.barY),
        to: Offset(maxX, connector.barY),
      );
    }

    for (final centerX in connector.childCenters) {
      final topY = connector.primaryChildTopY != null &&
              centerX == connector.childCenters.first
          ? connector.primaryChildTopY!
          : connector.childTopY;
      _drawStraightLine(
        canvas,
        paint: paint,
        from: Offset(centerX, connector.barY),
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
  bool shouldRepaint(covariant _FamilyConnectorPainter oldDelegate) {
    return oldDelegate.connectors != connectors;
  }
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
