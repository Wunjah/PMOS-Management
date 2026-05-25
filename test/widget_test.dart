// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:herhealth/main.dart';
import 'package:herhealth/screens/splash_screen.dart';

void main() {
  testWidgets('PMOSCareApp loads and displays splash screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PMOSCareApp());

    // Verify that the app is built successfully
    expect(find.byType(MaterialApp), findsOneWidget);
    
    // Verify that splash screen is displayed
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
