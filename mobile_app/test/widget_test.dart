import 'package:flutter_test/flutter_test.dart';
import 'package:vansha_mobile/main.dart';

void main() {
  testWidgets(
    'Vamsha app loads',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const VamshaApp(),
      );

      expect(
        find.byType(VamshaApp),
        findsOneWidget,
      );
    },
  );
}
