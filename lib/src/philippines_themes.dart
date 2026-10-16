import 'package:plate_core/plate_core.dart';
import 'package:flutter/widgets.dart';

import 'philippines_colors.dart';

/// The LTO liveries: one ink on one field, rim in the ink. Car and motorcycle
/// plates share them.
///
/// Rim 2.84 mm on the 140 mm car and 2.45 mm on the 135 mm motorcycle; corner
/// radius 8.3 and 8.7 mm. Both round to 0.02 and 0.06 of the height.
abstract final class PhilippinesThemes {
  static PlateTheme _livery({required Color ink, Color? field}) => PlateTheme(
    plateBackground: field ?? PhilippinesColors.white,
    plateBorder: ink,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0.06,
    activeColor: ink,
    inactiveColor: PhilippinesColors.inactive,
    alertColor: const Color(0xFFD32F2F),
  );

  /// Black on white: private vehicles, trailers, vintage and protocol plates.
  static final PlateTheme private = _livery(ink: PhilippinesColors.black);

  /// Green on white: electric and hybrid vehicles.
  static final PlateTheme electric = _livery(
    ink: PhilippinesColors.electricGreen,
  );

  /// Black on yellow: public utility and for-hire vehicles.
  static final PlateTheme publicUtility = _livery(
    ink: PhilippinesColors.black,
    field: PhilippinesColors.puvYellow,
  );

  /// Red on white: government vehicles.
  static final PlateTheme government = _livery(
    ink: PhilippinesColors.governmentRed,
  );

  /// Blue on white: diplomatic vehicles.
  static final PlateTheme diplomatic = _livery(
    ink: PhilippinesColors.diplomaticBlue,
  );
}
