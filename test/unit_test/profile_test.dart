import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/services/user_detail.dart';
import 'package:mobile/user_pages/profile.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

void main() {
  group('ProfilePage Widget Test', () {
    Future<void> _buildTestWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProfilePage(),
        ),
      );
    }

    testWidgets('Renders the ProfilePage UI correctly',
        (WidgetTester tester) async {
      await _buildTestWidget(tester);

      expect(find.byType(AppBar), findsOneWidget);

      expect(find.text('Password Lama :'), findsOneWidget);
      expect(find.text('Password Baru :'), findsOneWidget);
      expect(find.text('Konfirmasi Password :'), findsOneWidget);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
