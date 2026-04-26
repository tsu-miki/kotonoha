import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kotonoha_mobile/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders kotonoha title', (tester) async {
    await tester.pumpWidget(const KotonohaApp());
    await tester.pumpAndSettle();

    expect(find.text('kotonoha'), findsOneWidget);
  });
}
