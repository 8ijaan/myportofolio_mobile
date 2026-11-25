import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    // Ukuran layar ponsel, karena halaman utama dirancang untuk potret.
    tester.view.physicalSize = const Size(430, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final client = MockClient((_) async => http.Response('[]', 200));
    await tester.pumpWidget(MyApp(apiClient: ApiClient(client: client)));
  }

  testWidgets('project list is public', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Lihat Project'));
    await tester.pumpAndSettle();

    expect(find.text('No projects found.'), findsOneWidget);
  });

  testWidgets('adding a project requires login', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Tambah Project'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
