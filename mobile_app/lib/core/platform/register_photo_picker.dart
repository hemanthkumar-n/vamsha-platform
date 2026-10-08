import 'register_photo_picker_stub.dart'
    if (dart.library.js_interop) 'register_photo_picker_web.dart' as platform;

void registerPhotoPicker() => platform.registerPhotoPicker();
