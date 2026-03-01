import 'package:anipick/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('App smoke test', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pump();
  });
}
