import 'package:flutter/material.dart';

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
