import 'package:sembast_web/sembast_web.dart';

Future<Database> openProfileDatabase() =>
    databaseFactoryWeb.openDatabase('vamsha_profiles_v1');
