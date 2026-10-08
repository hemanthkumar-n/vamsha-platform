import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

Future<Database> openProfileDatabase() async {
  final directory = await getApplicationDocumentsDirectory();
  return databaseFactoryIo.openDatabase(
    '${directory.path}${Platform.pathSeparator}vamsha_profiles_v1.db',
  );
}
