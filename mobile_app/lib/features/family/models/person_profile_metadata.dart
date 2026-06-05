class PersonLanguageProfile {
  static const defaultUiLanguageTag = 'en';
  static const unknownLanguageTag = 'und';

  final String uiLanguageTag;
  final String motherTongueTag;
  final List<String> fluentLanguageTags;

  const PersonLanguageProfile({
    this.uiLanguageTag = defaultUiLanguageTag,
    this.motherTongueTag = unknownLanguageTag,
    this.fluentLanguageTags = const [],
  });

  String get primaryRelationshipLanguageTag {
    if (motherTongueTag != unknownLanguageTag) {
      return motherTongueTag;
    }
    if (fluentLanguageTags.isNotEmpty) {
      return fluentLanguageTags.first;
    }
    return uiLanguageTag;
  }

  String get motherTongueName => languageName(motherTongueTag);

  static String languageName(String languageTag) {
    return switch (languageTag.split('-').first) {
      'en' => 'English',
      'hi' => 'Hindi',
      'kn' => 'Kannada',
      'ml' => 'Malayalam',
      'ta' => 'Tamil',
      'te' => 'Telugu',
      _ => 'Not specified',
    };
  }
}

class PersonLocation {
  final String? countryCode;
  final String? administrativeArea;
  final String? locality;
  final String? nativePlace;

  const PersonLocation({
    this.countryCode,
    this.administrativeArea,
    this.locality,
    this.nativePlace,
  });
}

class PersonCulturalProfile {
  final String? religion;

  const PersonCulturalProfile({
    this.religion,
  });
}
