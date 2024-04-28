// FILEPATH: /Users/seb/Developer/AlgoSup/calculator/test/widgets/calculator_key_test.dart
import 'package:calculator/widgets/calculator_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('it should return tap value', (WidgetTester tester) async {
    String key = '1';
    bool wasTapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              CalculatorKey(
                value: key,
                height: 100.0,
                onTap: (value) {
                  expect(value, key);
                  wasTapped = true;
                },
              ),
            ],
          ),
        ),
      ),
    );

    // Verify that our CalculatorKey starts with the correct value.
    expect(find.text(key), findsOneWidget);

    // Tap the CalculatorKey and trigger a frame.
    await tester.tap(find.byType(CalculatorKey));
    await tester.pump();

    // Verify that our CalculatorKey has been tapped.
    expect(wasTapped, true);
  });
}
