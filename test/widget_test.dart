import 'package:flutter_test/flutter_test.dart';

import 'package:pamoja_thrift3_web/app.dart';

void main() {
  testWidgets('App renders without error', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Pamoja Thrift'), findsWidgets);
  });
}
