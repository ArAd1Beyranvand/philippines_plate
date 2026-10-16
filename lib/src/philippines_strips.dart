import 'package:flutter/widgets.dart';

import 'philippines_colors.dart';

/// Which edge of a motorcycle plate a region strip runs along.
enum PhilippinesStripEdge { top, bottom }

/// The colour-coded strip on a motorcycle plate issued since 2020, naming the
/// region of registration alongside the plate's first letter.
@immutable
class PhilippinesStrip {
  const PhilippinesStrip({
    required this.id,
    required this.region,
    required this.color,
    required this.edge,
  });

  /// Stable key, used in the spec id.
  final String id;
  final String region;
  final Color color;
  final PhilippinesStripEdge edge;
}

/// Every strip the article's table lists. Metro Manila (NCR) and government
/// motorcycles carry none: use `PhilippinesPlates.motorcycle()` without one.
///
/// The LTO also issues a region another region's strip when its own stock runs
/// short, so a strip names the region it was made for, not every region that
/// may carry it.
abstract final class PhilippinesStrips {
  static const PhilippinesStrip cordillera = PhilippinesStrip(
    id: 'car',
    region: 'Cordillera Administrative Region',
    color: PhilippinesColors.stripPink,
    edge: PhilippinesStripEdge.top,
  );
  static const PhilippinesStrip caraga = PhilippinesStrip(
    id: 'r13',
    region: 'Caraga',
    color: PhilippinesColors.stripPink,
    edge: PhilippinesStripEdge.bottom,
  );
  static const PhilippinesStrip ilocos = PhilippinesStrip(
    id: 'r1',
    region: 'Ilocos Region',
    color: PhilippinesColors.stripGreen,
    edge: PhilippinesStripEdge.top,
  );
  static const PhilippinesStrip easternVisayas = PhilippinesStrip(
    id: 'r8',
    region: 'Eastern Visayas',
    color: PhilippinesColors.stripGreen,
    edge: PhilippinesStripEdge.bottom,
  );
  static const PhilippinesStrip bicol = PhilippinesStrip(
    id: 'r5',
    region: 'Bicol Region',
    color: PhilippinesColors.stripGray,
    edge: PhilippinesStripEdge.top,
  );
  static const PhilippinesStrip northernMindanao = PhilippinesStrip(
    id: 'r10',
    region: 'Northern Mindanao',
    color: PhilippinesColors.stripGray,
    edge: PhilippinesStripEdge.bottom,
  );
  static const PhilippinesStrip centralLuzon = PhilippinesStrip(
    id: 'r3',
    region: 'Central Luzon',
    color: PhilippinesColors.stripBlue,
    edge: PhilippinesStripEdge.top,
  );
  static const PhilippinesStrip davao = PhilippinesStrip(
    id: 'r11',
    region: 'Davao Region',
    color: PhilippinesColors.stripBlue,
    edge: PhilippinesStripEdge.bottom,
  );
  static const PhilippinesStrip calabarzon = PhilippinesStrip(
    id: 'r4a',
    region: 'Calabarzon',
    color: PhilippinesColors.stripPurple,
    edge: PhilippinesStripEdge.top,
  );
  static const PhilippinesStrip westernVisayas = PhilippinesStrip(
    id: 'r6',
    region: 'Western Visayas',
    color: PhilippinesColors.stripPurple,
    edge: PhilippinesStripEdge.bottom,
  );
  static const PhilippinesStrip mimaropa = PhilippinesStrip(
    id: 'r4b',
    region: 'Mimaropa',
    color: PhilippinesColors.stripOrange,
    edge: PhilippinesStripEdge.top,
  );
  static const PhilippinesStrip centralVisayas = PhilippinesStrip(
    id: 'r7',
    region: 'Central Visayas',
    color: PhilippinesColors.stripOrange,
    edge: PhilippinesStripEdge.bottom,
  );
  static const PhilippinesStrip cagayanValley = PhilippinesStrip(
    id: 'r2',
    region: 'Cagayan Valley',
    color: PhilippinesColors.stripRed,
    edge: PhilippinesStripEdge.top,
  );
  static const PhilippinesStrip zamboanga = PhilippinesStrip(
    id: 'r9',
    region: 'Zamboanga Peninsula',
    color: PhilippinesColors.stripRed,
    edge: PhilippinesStripEdge.bottom,
  );
  static const PhilippinesStrip soccsksargen = PhilippinesStrip(
    id: 'r12',
    region: 'Soccsksargen',
    color: PhilippinesColors.stripBrown,
    edge: PhilippinesStripEdge.bottom,
  );

  static const List<PhilippinesStrip> all = <PhilippinesStrip>[
    cordillera,
    caraga,
    ilocos,
    easternVisayas,
    bicol,
    northernMindanao,
    centralLuzon,
    davao,
    calabarzon,
    westernVisayas,
    mimaropa,
    centralVisayas,
    cagayanValley,
    zamboanga,
    soccsksargen,
  ];
}
