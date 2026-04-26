import 'package:flutter_test/flutter_test.dart';

import 'package:kotonoha_mobile/main.dart';

void main() {
  testWidgets('renders kotonoha title', (WidgetTester tester) async {
    await tester.pumpWidget(const KotonohaApp());

    expect(find.text('kotonoha'), findsOneWidget);
  });
}
