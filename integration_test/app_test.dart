import 'package:calculator/main.dart' as app;
import 'package:calculator/widgets/calculator_key.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Calculator App E2E Tests', () {
    testWidgets('Perform simple addition', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tap the '6' key
      await tester.tap(find.widgetWithText(CalculatorKey, '6'));
      await tester.pumpAndSettle();

      // Tap the '*' key
      await tester.tap(find.widgetWithText(CalculatorKey, '*'));
      await tester.pumpAndSettle();

      // Tap the '8' key
      await tester.tap(find.widgetWithText(CalculatorKey, '8'));
      await tester.pumpAndSettle();

      // Tap the '=' key
      await tester.tap(find.widgetWithText(CalculatorKey, '='));
      await tester.pumpAndSettle();

      // Verify the result
      expect(find.text('48'), findsOneWidget);
    });
  });
}
