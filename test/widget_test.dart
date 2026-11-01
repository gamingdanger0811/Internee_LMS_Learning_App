import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intro_app/main.dart';

void main() {
  test('every demo lesson has a valid YouTube video ID', () {
    final lessons = courses.expand((course) => course.lessons);

    expect(lessons, isNotEmpty);
    expect(
      lessons.every(
        (lesson) => RegExp(r'^[A-Za-z0-9_-]{11}$').hasMatch(lesson.videoId),
      ),
      isTrue,
    );
    expect(
      lessons.map((lesson) => lesson.videoId).toSet().length,
      lessons.length,
    );
  });

  testWidgets('home opens and course catalog can be browsed', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const InterneeLmsApp());

    expect(find.text('Good morning, learner 👋'), findsOneWidget);
    await tester.tap(find.text('Explore').last);
    await tester.pumpAndSettle();

    expect(find.text('Explore courses'), findsOneWidget);
    expect(find.text('Flutter App Development'), findsOneWidget);
    expect(find.text('Modern Web Development'), findsOneWidget);
  });

  testWidgets('quiz gives immediate feedback and records the best score', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const InterneeLmsApp());
    await tester.tap(find.text('Continue learning'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Knowledge check'), 250);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Knowledge check'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Dart'), 180);
    await tester.tap(find.text('Dart'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Check answer'), 180);
    await tester.tap(find.text('Check answer'));
    await tester.pumpAndSettle();
    expect(find.textContaining('That’s right!'), findsOneWidget);
    expect(find.text('Score: 1'), findsOneWidget);

    await tester.tap(find.text('Next question'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('A UI building block'), 180);
    await tester.tap(find.text('A UI building block'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Check answer'), 180);
    await tester.tap(find.text('Check answer'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Next question'), 180);
    await tester.tap(find.text('Next question'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Column'), 180);
    await tester.tap(find.text('Column'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Check answer'), 180);
    await tester.tap(find.text('Check answer'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('See my results'));
    await tester.pumpAndSettle();

    expect(find.text('You scored 3 out of 3 (100%).'), findsOneWidget);
    await tester.tap(find.text('Back to course'));
    await tester.pumpAndSettle();
    expect(find.text('Best score: 3/3'), findsOneWidget);
  });
}
