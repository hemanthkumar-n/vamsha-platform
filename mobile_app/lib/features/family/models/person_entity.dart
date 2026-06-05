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

  const PersonEntity({
    required this.id,
    required this.primaryName,
    this.gender = Gender.unknown,
    this.aliases = const [],
    this.knownAs = const [],
  });
}
