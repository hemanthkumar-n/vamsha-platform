import 'package:flutter_test/flutter_test.dart';
import 'package:vansha_mobile/features/family/models/founder_graph.dart';
import 'package:vansha_mobile/features/family/web/family_web_layout.dart';

void main() {
  test('founder family web layout references valid graph entities', () {
    const layout = FounderFamilyWebLayout.layout;

    expect(
      layout.focalPointForViewer('doguparthi_siva_prasad'),
      const Offset(175, 800),
    );
    expect(
      layout.focalPointForViewer('doguparthi_jayamma'),
      const Offset(505, 800),
    );
    expect(
      layout.focalPointForViewer('doguparthi_kiran'),
      const Offset(340, 1090),
    );
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

    expect(layout.focalPointForViewer('prasad'), const Offset(995, 445));
    expect(layout.focalPointForViewer('hemanth'), const Offset(1180, 830));
    expect(layout.focalPointForViewer('sudha'), const Offset(1325, 445));
    expect(layout.focalPointForViewer('keerthi'), const Offset(780, 850));
    expect(layout.focalPointForViewer('divya'), const Offset(1580, 850));
    expect(layout.focalPointForViewer('yuvan'), const Offset(1030, 1270));
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

    final doguparthiParents = layout.familyUnits.singleWhere(
      (unit) => unit.familyUnitId == 'fu_doguparthi_parents',
    );
    expect(doguparthiParents.position, const Offset(80, 700));
    expect(
      layout.people.any((node) => node.personId == 'doguparthi_kiran'),
      isTrue,
    );
  });
}
