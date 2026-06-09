import 'dart:convert';
import 'dart:io';

import 'package:vansha_mobile/features/family/models/founder_graph.dart';

void main() {
  const encoder = JsonEncoder.withIndent('  ');
  stdout.writeln(encoder.convert(FounderGraph.localData.toJson()));
}
