import 'package:calculator/calculator.dart';
import 'package:calculator/widgets/calculator_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculator Widget Tests', () {
    testWidgets('Adding and Clearing Operations', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      // Render the Calculator widget
      await tester.pumpWidget(const MaterialApp(home: Calculator()));
      // Verify initial state
      expect(find.text('0'), findsExactly(2)); // Initial result is 0 + key 0
      // Or only result
      expect(
        find.byWidgetPredicate(
          (Widget widget) => widget is Text && widget.data == '0' && widget.style?.fontSize == 48.0,
        ),
        findsOneWidget,
      );

      // Check if compute is empty
      expect(find.text(''), findsOneWidget);

      // Check if we have all the keys
      expect(
        find.byWidgetPredicate((Widget widget) => widget is CalculatorKey),
        findsExactly(19),
      );

      // Tap '1' key
      await tester.tap(find.widgetWithText(CalculatorKey, '1'));
      await tester.pump();

      // Tap '+' key
      await tester.tap(find.widgetWithText(CalculatorKey, '+'));
      await tester.pump();

      // Tap '2' key
      await tester.tap(find.widgetWithText(CalculatorKey, '2'));
      await tester.pump();

      // Verify operation is '1+2'
      expect(find.text('1+2'), findsOneWidget);

      // Clear operation
      await tester.tap(find.widgetWithText(CalculatorKey, 'AC'));
      await tester.pump();

      // Verify operation is cleared
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('Computing Operations', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      // Render the Calculator widget
      await tester.pumpWidget(const MaterialApp(home: Calculator()));

      // Input '3*3'
      await tester.tap(find.widgetWithText(CalculatorKey, '3'));
      await tester.pump();
      await tester.tap(find.widgetWithText(CalculatorKey, '*'));
      await tester.pump();
      await tester.tap(find.widgetWithText(CalculatorKey, '9'));
      await tester.pump();

      // Compute the result
      await tester.tap(find.widgetWithText(CalculatorKey, '='));
      await tester.pump();

      // Verify result is '9'
      expect(find.text('27'), findsOneWidget);

      // Verify operation is cleared after computing
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('Handling Error in Expression', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 1920);

      // Render the Calculator widget
      await tester.pumpWidget(const MaterialApp(home: Calculator()));

      // Input an invalid operation '3//3'
      await tester.tap(find.widgetWithText(CalculatorKey, '3'));
      await tester.pump();
      await tester.tap(find.widgetWithText(CalculatorKey, '/'));
      await tester.pump();
      await tester.tap(find.widgetWithText(CalculatorKey, '/'));
      await tester.pump();
      await tester.tap(find.widgetWithText(CalculatorKey, '3'));
      await tester.pump();

      // Attempt to compute the result
      await tester.tap(find.widgetWithText(CalculatorKey, '='));
      await tester.pump();

      // Verify error is displayed
      expect(find.text('Error in expression'), findsOneWidget);
    });
  });
}
