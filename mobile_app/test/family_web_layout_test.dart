import 'package:flutter_test/flutter_test.dart';
import 'package:vansha_mobile/features/family/models/founder_graph.dart';
import 'package:vansha_mobile/features/family/web/family_web_layout.dart';

void main() {
  test('founder family web layout references valid graph entities', () {
    const layout = FounderFamilyWebLayout.layout;

    for (final node in layout.people) {
      expect(FounderGraph.personById(node.personId).id, node.personId);
    }

    for (final unitLayout in layout.familyUnits) {
      final unit = FounderGraph.familyUnitById(unitLayout.familyUnitId);
      expect(FounderGraph.personById(unit.partner1Id).id, unit.partner1Id);
      expect(FounderGraph.personById(unit.partner2Id).id, unit.partner2Id);
    }
  });

  test('founder family web layout defines viewer camera focal points', () {
    const layout = FounderFamilyWebLayout.layout;

    expect(layout.focalPointForViewer('hemanth'), const Offset(1180, 830));
    expect(layout.focalPointForViewer('sudha'), const Offset(1305, 445));
    expect(
      layout.focalPointForViewer('unknown'),
      Offset(layout.width / 2, layout.height / 2),
    );
  });

  test('every family unit renders as a split married couple', () {
    const layout = FounderFamilyWebLayout.layout;

    expect(layout.familyUnits.every((unit) => unit.splitPartners), isTrue);

    final parents = layout.familyUnits.singleWhere(
      (unit) => unit.familyUnitId == 'fu_prasad_sudha',
    );
    expect(parents.position, const Offset(900, 350));

    final natakamRoot = layout.familyUnits.singleWhere(
      (unit) => unit.familyUnitId == 'fu_natakam_root',
    );
    final mamidiRoot = layout.familyUnits.singleWhere(
      (unit) => unit.familyUnitId == 'fu_mamidi_root',
    );
    expect(natakamRoot.position, const Offset(530, 100));
    expect(mamidiRoot.position, const Offset(1330, 100));
  });
}
