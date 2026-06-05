import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vansha_mobile/features/family/web/family_web_layout.dart';
import 'package:vansha_mobile/main.dart';

void main() {
  testWidgets(
    'family web stays primary and projection demo is navigable',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const VamshaApp(),
      );

      expect(find.text('Vamsha Family Web'), findsOneWidget);
      expect(find.text('Family Web'), findsOneWidget);
      expect(find.text('Projection'), findsOneWidget);
      expect(find.text('Paternal Uncle'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('couple-person-prasad')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('couple-person-sudha')),
        findsOneWidget,
      );
      expect(find.text('Married'), findsOneWidget);
      expect(find.text('Father'), findsOneWidget);
      expect(find.text('Mother'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('family-web-interactive-viewer')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('center-on-viewer')), findsOneWidget);

      await tester.tap(
        find.byKey(const ValueKey('select-viewer-sudha')),
      );
      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byKey(const ValueKey('select-viewer-sudha')),
          matching: find.byIcon(Icons.check),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('couple-person-sudha')),
          matching: find.text('YOU'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('couple-person-prasad')),
          matching: find.text('Husband'),
        ),
        findsOneWidget,
      );
      expect(find.text('Brother-in-law'), findsWidgets);
      expect(find.text('Daughter-in-law'), findsOneWidget);
      expect(find.text('Son-in-law'), findsOneWidget);
      expect(find.text('Grandson'), findsWidgets);
      expect(find.text('Granddaughter'), findsWidgets);

      await tester
          .tap(find.widgetWithText(NavigationDestination, 'Projection'));
      await tester.pumpAndSettle();

      expect(
        find.text('Same person. Different viewer. Different relationship.'),
        findsOneWidget,
      );
      expect(find.text('Mother'), findsOneWidget);
      expect(find.text('Father'), findsOneWidget);
      expect(find.text('Sister'), findsOneWidget);

      await tester.tap(find.widgetWithText(ChoiceChip, 'Sudha Rani'));
      await tester.pumpAndSettle();

      expect(find.text('Husband'), findsOneWidget);
      expect(find.text('Daughter'), findsOneWidget);
      expect(find.text('Father-in-law'), findsOneWidget);
      expect(find.text('Mamayya'), findsOneWidget);
      expect(find.text('Athamma'), findsOneWidget);
    },
  );

  testWidgets('family web centers each viewer on a phone viewport',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const VamshaApp());
    await tester.pumpAndSettle();

    void expectViewerCentered(String viewerId) {
      final interactiveViewer = tester.widget<InteractiveViewer>(
        find.byKey(const ValueKey('family-web-interactive-viewer')),
      );
      final viewportSize = tester.getSize(
        find.byKey(const ValueKey('family-web-interactive-viewer')),
      );
      final visibleFocalPoint = MatrixUtils.transformPoint(
        interactiveViewer.transformationController!.value,
        FounderFamilyWebLayout.layout.focalPointForViewer(viewerId),
      );

      expect(
        visibleFocalPoint.dx,
        moreOrLessEquals(viewportSize.width / 2, epsilon: 0.5),
      );
      expect(
        visibleFocalPoint.dy,
        moreOrLessEquals(viewportSize.height / 2, epsilon: 0.5),
      );
    }

    expectViewerCentered('hemanth');
    expect(tester.takeException(), isNull);
    expect(find.text('Hemanth'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('select-viewer-sudha')));
    await tester.pumpAndSettle();

    expectViewerCentered('sudha');
    expect(find.text('Sudha'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
