class PersonEntity {
  final String id;

  final String primaryName;

  final List<String> aliases;

  final List<String> knownAs;

  const PersonEntity({
    required this.id,
    required this.primaryName,
    this.aliases = const [],
    this.knownAs = const [],
  });
}

