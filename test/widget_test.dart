// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';
import 'package:principal_shalom/ui/login_page.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // The controller works
    Get.put(ControlPersonas());
    await tester.takeException();
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Login());
  });
}
