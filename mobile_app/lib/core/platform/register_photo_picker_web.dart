import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';

void registerPhotoPicker() =>
    ImagePickerPlugin.registerWith(webPluginRegistrar);
