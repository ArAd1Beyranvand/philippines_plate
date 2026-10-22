import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:philippines_plate/philippines_plate.dart';
import 'package:plate_core/plate_core.dart';

/// One golden per category, drawn with a real bold face so the ink can be
/// measured against the references (see `_Layout` in `philippines_plates.dart`).
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  setUpAll(() async {
    final FontLoader loader = FontLoader('Roboto');
    final File face = File('/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf');
    if (face.existsSync()) {
      loader.addFont(face.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  });

  Future<void> render(
    WidgetTester tester, {
    required PlateSpec spec,
    required PlateTheme theme,
    required String text,
    required String name,
  }) async {
    final PlateController controller = PlateController.fromText(spec, text);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 520,
              height: 520 * spec.canvasHeight / spec.canvasWidth,
              child: PlateThemeScope(
                theme: theme,
                child: PlateView(
                  controller: controller,
                  theme: theme,
                  country: PhilippinesCountry.philippines,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(find.byType(PlateView), matchesGoldenFile('goldens/$name.png'));
    await tester.pumpWidget(const SizedBox.shrink());
    controller.dispose();
  }

  final List<(String, PlateSpec, PlateTheme, String)> plates = [
    ('ph_private', PhilippinesPlates.car(), PhilippinesThemes.private, 'NBC 1234'),
    ('ph_private_3', PhilippinesPlates.car(digits: 3), PhilippinesThemes.private, 'ABC 888'),
    ('ph_private_2', PhilippinesPlates.car(digits: 2), PhilippinesThemes.private, 'ABC 01'),
    ('ph_electric', PhilippinesPlates.car(), PhilippinesThemes.electric, 'NEV 1234'),
    ('ph_puv', PhilippinesPlates.car(), PhilippinesThemes.publicUtility, 'NBC 1234'),
    ('ph_government', PhilippinesPlates.car(), PhilippinesThemes.government, 'SAB 1234'),
    ('ph_diplomatic', PhilippinesPlates.diplomatic, PhilippinesThemes.diplomatic, '002 0020'),
    ('ph_vintage', PhilippinesPlates.vintage, PhilippinesThemes.private, 'NTX 1006 1965'),
    ('ph_motorcycle', PhilippinesPlates.motorcycle(), PhilippinesThemes.private, '321NBC'),
    for (final PhilippinesStrip s in PhilippinesStrips.all)
      (
        'ph_motorcycle_${s.id}',
        PhilippinesPlates.motorcycle(strip: s),
        PhilippinesThemes.private,
        '123ABC',
      ),
  ];
  for (final (String name, PlateSpec spec, PlateTheme theme, String text) in plates) {
    testWidgets(name, (tester) async {
      await render(tester, spec: spec, theme: theme, text: text, name: name);
    });
  }
}
