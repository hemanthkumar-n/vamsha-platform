import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:vansha_mobile/features/family/data/local_profiles/local_profile_store.dart';
import 'package:vansha_mobile/features/family/models/founder_graph.dart';

void main() {
  test('profile and photo persist by person ID without changing graph links',
      () async {
    final database = await databaseFactoryMemory.openDatabase('profile-test');
    final store = LocalProfileStore(database);
    const original = FounderGraph.localData;
    final person = original.people.firstWhere((person) => person.id == 'yuvan');
    final photo = Uint8List.fromList([1, 2, 3, 4]);

    await store.saveProfile(
      person: person,
      name: 'Yuvan Simha',
      aliases: ['Yuvan'],
      knownAs: ['Yuvi'],
      nativePlace: 'Bengaluru',
      religion: '',
      photoBytes: photo,
      photoContentType: 'image/jpeg',
    );
    final afterRestart = LocalProfileStore(database);
    final loaded = await afterRestart.applyTo(original);
    final updated = loaded.people.firstWhere((person) => person.id == 'yuvan');

    expect(updated.id, 'yuvan');
    expect(updated.primaryName, 'Yuvan Simha');
    expect(updated.aliases, ['Yuvan']);
    expect(updated.knownAs, ['Yuvi']);
    expect(updated.location.nativePlace, 'Bengaluru');
    expect(await afterRestart.photoFor('yuvan'), photo);
    expect(await afterRestart.photoFor('divya'), isNull);
    expect(loaded.relationships.length, original.relationships.length);
    expect(loaded.familyUnits.length, original.familyUnits.length);
    expect(LocalProfileStore.photoAssetKey('yuvan'),
        'founder_family/yuvan/profile');
    await database.close();
  });
}
