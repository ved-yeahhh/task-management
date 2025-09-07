import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_mgmt/main.dart'; // adjust to your entry point

void main() {
  testWidgets('App loads Task Management home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Check if title or main screen text exists
    expect(find.text('Task Management'), findsOneWidget);
  });

  testWidgets('Add a new task and verify it appears', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap on add task button (change the icon if you used another)
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter task name
    await tester.enterText(find.byType(TextField), 'Buy groceries');
    await tester.tap(find.text('Save')); // change if button label is different
    await tester.pumpAndSettle();

    // Verify new task appears
    expect(find.text('Buy groceries'), findsOneWidget);
  });

  testWidgets('Mark task as complete', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Add a task
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Complete homework');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Tap checkbox (assuming you use CheckboxListTile or similar)
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    // Verify UI change (you might change style or show completed state)
    expect(find.text('Complete homework'), findsOneWidget);
  });
}
