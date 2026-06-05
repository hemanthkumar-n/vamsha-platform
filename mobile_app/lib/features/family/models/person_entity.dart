import 'person_profile_metadata.dart';

enum Gender {
  male,
  female,
  unknown,
}

class PersonEntity {
  final String id;
  final String primaryName;
  final Gender gender;
  final List<String> aliases;
  final List<String> knownAs;
  final PersonLanguageProfile languageProfile;
  final PersonLocation location;
  final PersonCulturalProfile culturalProfile;

  const PersonEntity({
    required this.id,
    required this.primaryName,
    this.gender = Gender.unknown,
    this.aliases = const [],
    this.knownAs = const [],
    this.languageProfile = const PersonLanguageProfile(),
    this.location = const PersonLocation(),
    this.culturalProfile = const PersonCulturalProfile(),
  });
}
