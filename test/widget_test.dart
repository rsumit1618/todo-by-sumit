import 'package:data/di/local_di.dart';
import 'package:data/helper/app_local_database_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_architecture/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('App starts on todo home route', (WidgetTester tester) async {
    final db = await AppLocalDatabase.create();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appLocalDatabaseProvider.overrideWithValue(db),
        ],
        child: const MyApp(),
      ),
    );

    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
