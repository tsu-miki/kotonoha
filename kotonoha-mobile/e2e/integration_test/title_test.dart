import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kotonoha_mobile/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('KotonohaApp', () {
    testWidgets('アプリを起動するとタイトル「kotonoha」が画面中央に表示される',
        (tester) async {
      // Given: アプリを起動して描画が安定するまで待つ
      await tester.pumpWidget(const KotonohaApp());
      await tester.pumpAndSettle();

      // Then: タイトル「kotonoha」が画面に1件表示されている
      expect(find.text('kotonoha'), findsOneWidget);
    });
  });
}
