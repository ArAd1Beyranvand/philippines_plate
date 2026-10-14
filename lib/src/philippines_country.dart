import 'package:plate_core/plate_core.dart';

import 'philippines_colors.dart';

/// The Philippines as a `PlateCountry`. The 2018 plates print no flag, country
/// name or region caption, so every spec sets `noPanel`.
abstract final class PhilippinesCountry {
  static const PlateCountry philippines = PlateCountry(
    code: 'ph',
    captionLines: <String>[],
    panelColor: PhilippinesColors.white,
    panelTextColor: PhilippinesColors.black,
  );
}
