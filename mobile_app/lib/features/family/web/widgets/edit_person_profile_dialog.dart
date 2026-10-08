import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/local_profiles/local_profile_store.dart';
import '../../models/person_entity.dart';

class EditPersonProfileDialog extends StatefulWidget {
  final PersonEntity person;
  final LocalProfileStore store;

  const EditPersonProfileDialog({
    super.key,
    required this.person,
    required this.store,
  });

  @override
  State<EditPersonProfileDialog> createState() =>
      _EditPersonProfileDialogState();
}

class _EditPersonProfileDialogState extends State<EditPersonProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _knownAs;
  late final TextEditingController _aliases;
  late final TextEditingController _nativePlace;
  late final TextEditingController _religion;
  Uint8List? _photo;
  String? _photoContentType;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final person = widget.person;
    _name = TextEditingController(text: person.primaryName);
    _knownAs = TextEditingController(text: person.knownAs.join(', '));
    _aliases = TextEditingController(text: person.aliases.join(', '));
    _nativePlace = TextEditingController(text: person.location.nativePlace);
    _religion = TextEditingController(text: person.culturalProfile.religion);
    widget.store.photoFor(person.id).then((bytes) {
      if (mounted) setState(() => _photo = bytes);
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _knownAs.dispose();
    _aliases.dispose();
    _nativePlace.dispose();
    _religion.dispose();
    super.dispose();
  }

  Future<void> _choosePhoto() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        imageQuality: 82,
      );
      if (image == null) return;
      final bytes = await image.readAsBytes();
      if (bytes.lengthInBytes > 4 * 1024 * 1024) {
        throw const FormatException('Choose a photo smaller than 4 MB.');
      }
      if (!mounted) return;
      setState(() {
        _photo = bytes;
        _photoContentType = image.mimeType ?? 'image/jpeg';
      });
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not select photo: $error')),
      );
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await widget.store.saveProfile(
        person: widget.person,
        name: _name.text.trim(),
        aliases: _split(_aliases.text),
        knownAs: _split(_knownAs.text),
        nativePlace: _nativePlace.text.trim(),
        religion: _religion.text.trim(),
        photoBytes: _photoContentType == null ? null : _photo,
        photoContentType: _photoContentType,
      );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save profile: $error')),
      );
    }
  }

  static List<String> _split(String text) => text
      .split(',')
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .toList();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit ${widget.person.primaryName}'),
      content: SizedBox(
        width: 440,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundImage: _photo == null ? null : MemoryImage(_photo!),
                  child: _photo == null
                      ? const Icon(Icons.person, size: 36)
                      : null,
                ),
                TextButton.icon(
                  key: const ValueKey('choose-profile-photo'),
                  onPressed: _saving ? null : _choosePhoto,
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('Choose photo'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  key: const ValueKey('edit-profile-name'),
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Full name'),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Enter a name'
                      : null,
                ),
                TextFormField(
                  controller: _knownAs,
                  decoration: const InputDecoration(
                    labelText: 'Known as',
                    helperText: 'Separate multiple names with commas',
                  ),
                ),
                TextFormField(
                  controller: _aliases,
                  decoration: const InputDecoration(
                    labelText: 'Other names',
                    helperText: 'Separate multiple names with commas',
                  ),
                ),
                TextFormField(
                  controller: _nativePlace,
                  decoration: const InputDecoration(labelText: 'Native place'),
                ),
                TextFormField(
                  controller: _religion,
                  decoration: const InputDecoration(labelText: 'Religion'),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const ValueKey('save-profile'),
          onPressed: _saving ? null : _save,
          child: Text(_saving ? 'Saving…' : 'Save locally'),
        ),
      ],
    );
  }
}
