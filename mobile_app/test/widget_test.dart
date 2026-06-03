import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
}
