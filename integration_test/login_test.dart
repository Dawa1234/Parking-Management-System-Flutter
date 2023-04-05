import 'package:epark/screens/authenticationScreen/loginPage.dart';
import 'package:epark/routes.dart';
import 'package:epark/screens/authenticationScreen/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("Login and register", () {
    testWidgets('login and route to dashboard', (widgetTester) async {
      await widgetTester.pumpWidget(ProviderScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: true,
          initialRoute: LoginPageScreen.route,
          routes: getAppRoutes,
        ),
      ));
      // Username TextFormField
      Finder txtUsername = find.byKey(const ValueKey('txtUsername'));
      await widgetTester.enterText(txtUsername, 'user1');

      // Password TextFormField
      Finder txtPassword = find.byKey(const ValueKey('txtPassword'));

      await widgetTester.enterText(txtPassword, '123123123');

      // // Click/tap login button
      // Finder loginBtn = find.byKey(const ValueKey("btnLogin"));
      // await widgetTester.tap(loginBtn);
      await widgetTester.ensureVisible(find.byType(ElevatedButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(ElevatedButton));

      // wait for the test to complete.
      await widgetTester.pumpAndSettle(const Duration(seconds: 5));

      Finder homeScreen = find.text('Home');
      expect(homeScreen, findsOneWidget);
    });

    testWidgets('register and route to login', (widgetTester) async {
      await widgetTester.pumpWidget(ProviderScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: true,
          initialRoute: RegsiterScreen.route,
          routes: getAppRoutes,
        ),
      ));
      // Username TextFormField
      Finder txtfullname = find.byKey(const ValueKey('fullNameKey'));
      await widgetTester.enterText(txtfullname, 'john123');

      // Password TextFormField
      Finder txtEmail = find.byKey(const ValueKey('emailKey'));
      await widgetTester.enterText(txtEmail, 'david@gmail.com');
      // Username TextFormField
      Finder txtContact = find.byKey(const ValueKey('contactKey'));
      await widgetTester.enterText(txtContact, '9893829342');

      // Username TextFormField
      Finder txtUsername = find.byKey(const ValueKey('usernameKey'));
      await widgetTester.enterText(txtUsername, 'david1111');

      // Password TextFormField
      Finder txtPassword = find.byKey(const ValueKey('passwordKey'));
      await widgetTester.enterText(txtPassword, '123123123');

      // Password TextFormField
      Finder txtConfirmPassword =
          find.byKey(const ValueKey('confirmPasswordKey'));
      await widgetTester.enterText(txtConfirmPassword, '123123123');

      // // Click/tap login button
      // Finder loginBtn = find.byKey(const ValueKey("btnLogin"));
      // await widgetTester.tap(loginBtn);
      await widgetTester.ensureVisible(find.byType(ElevatedButton));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(ElevatedButton), warnIfMissed: false);

      // wait for the test to complete.
      await widgetTester.pumpAndSettle(const Duration(seconds: 5));

      Finder loginScreen = find.text('LOGIN');
      expect(loginScreen, findsOneWidget);
    });
  });
}
