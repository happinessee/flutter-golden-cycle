import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimal_flutter_example/widgets/primary_button.dart';

import '../helpers/golden_host.dart';

Future<void> main() async {
  await setUpGoldenFonts();

  group('PrimaryButton', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(
        goldenHost(child: PrimaryButton(label: 'Tap', onPressed: () {})),
      );
      expect(find.text('Tap'), findsOneWidget);
    });

    testWidgets('golden: default', (tester) async {
      await useGoldenViewport(tester);
      await tester.pumpWidget(
        goldenHost(child: PrimaryButton(label: 'Tap', onPressed: () {})),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../goldens/primary_button/default.png'),
        skip: true, // CI: baseline not committed until /flutter-golden-cycle-baseline runs.
      );
    });

    testWidgets('golden: disabled', (tester) async {
      await useGoldenViewport(tester);
      await tester.pumpWidget(
        goldenHost(
          child: PrimaryButton(label: 'Tap', onPressed: () {}, enabled: false),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../goldens/primary_button/disabled.png'),
        skip: true,
      );
    });
  });
}
