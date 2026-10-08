import 'package:sembast/sembast.dart';

import 'open_profile_database_unsupported.dart'
    if (dart.library.io) 'open_profile_database_io.dart'
    if (dart.library.js_interop) 'open_profile_database_web.dart' as platform;

Future<Database> openProfileDatabase() => platform.openProfileDatabase();
