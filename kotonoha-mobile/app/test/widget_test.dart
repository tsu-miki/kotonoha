import 'package:flutter_test/flutter_test.dart';

import 'package:kotonoha_mobile/main.dart';

void main() {
  group('KotonohaApp', () {
    testWidgets('起動するとタイトル「kotonoha」が画面に表示される', (tester) async {
      // Given: ルートウィジェットをポンプする
      await tester.pumpWidget(const KotonohaApp());

      // Then: タイトル「kotonoha」が1件表示されている
      expect(find.text('kotonoha'), findsOneWidget);
    });
  });
}
