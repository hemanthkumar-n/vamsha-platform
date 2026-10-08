import 'dart:convert';
import 'dart:typed_data';

import 'package:sembast/sembast.dart';

import '../../models/family_graph_data.dart';
import '../../models/person_entity.dart';
import '../../models/person_profile_metadata.dart';

/// Local edits are keyed by the stable person ID, independent of the seed graph.
class LocalProfileStore {
  static LocalProfileStore? current;

  static final _profiles = stringMapStoreFactory.store('person_profiles');
  static final _photos = stringMapStoreFactory.store('profile_photos');
  final Database database;

  LocalProfileStore(this.database);

  Future<FamilyGraphData> applyTo(FamilyGraphData graph) async {
    final saved = await _profiles.find(database);
    final byId = {for (final record in saved) record.key: record.value};
    return FamilyGraphData(
      people: graph.people.map((person) {
        final details = byId[person.id];
        return details == null ? person : _withDetails(person, details);
      }).toList(),
      familyUnits: graph.familyUnits,
      relationships: graph.relationships,
      viewerRelationshipOverrides: graph.viewerRelationshipOverrides,
    );
  }

  Future<void> saveProfile({
    required PersonEntity person,
    required String name,
    required List<String> aliases,
    required List<String> knownAs,
    required String nativePlace,
    required String religion,
    Uint8List? photoBytes,
    String? photoContentType,
  }) async {
    await database.transaction((transaction) async {
      await _profiles.record(person.id).put(transaction, {
        'name': name,
        'aliases': aliases,
        'knownAs': knownAs,
        'nativePlace': nativePlace,
        'religion': religion,
      });
      if (photoBytes != null) {
        await _photos.record(person.id).put(transaction, {
          'assetKey': 'founder_family/${person.id}/profile',
          'contentType': photoContentType ?? 'image/jpeg',
          'bytes': base64Encode(photoBytes),
        });
      }
    });
  }

  Future<Uint8List?> photoFor(String personId) async {
    final photo = await _photos.record(personId).get(database);
    final encoded = photo?['bytes'];
    return encoded is String ? base64Decode(encoded) : null;
  }

  /// Stable object key reserved for a later cloud-storage migration.
  static String photoAssetKey(String personId) =>
      'founder_family/$personId/profile';

  static PersonEntity _withDetails(
    PersonEntity person,
    Map<String, Object?> details,
  ) {
    return PersonEntity(
      id: person.id,
      primaryName: details['name'] as String? ?? person.primaryName,
      gender: person.gender,
      siblingOrder: person.siblingOrder,
      aliases: (details['aliases'] as List?)?.cast<String>() ?? person.aliases,
      knownAs: (details['knownAs'] as List?)?.cast<String>() ?? person.knownAs,
      languageProfile: person.languageProfile,
      location: PersonLocation(
        countryCode: person.location.countryCode,
        administrativeArea: person.location.administrativeArea,
        locality: person.location.locality,
        nativePlace:
            details['nativePlace'] as String? ?? person.location.nativePlace,
      ),
      culturalProfile: PersonCulturalProfile(
        religion:
            details['religion'] as String? ?? person.culturalProfile.religion,
      ),
    );
  }
}
