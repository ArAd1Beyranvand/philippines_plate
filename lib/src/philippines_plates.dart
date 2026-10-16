import 'package:plate_core/plate_core.dart';

import 'philippines_alphabets.dart';
import 'philippines_country.dart';
import 'philippines_missions.dart';
import 'philippines_regions.dart';
import 'philippines_strips.dart';

/// Where the ink sits on a 2018-series plate, in millimetres, measured off the
/// Commons artwork, which is drawn at the documented sizes (4680×1680 px =
/// 390×140 mm, 2820×1620 px = 235×135 mm).
///
/// Car (`NBC_1234`, `ABC_888`, `ABC_01`, `002_0020_diplomatic`, vintage):
/// * ink rows y 34.1..106.1 (72 tall, centred on the plate);
/// * letter ink 16.9–50.8, 63.0–96.9, 109.5–142.6; digit ink 200.7–233.2 …
///   339.4–372.1: one pitch of 46.25 for letters and digits alike;
/// * the letter→digit ink gap is 58.9 for 2, 3 and 4 digits — one empty cell —
///   and the whole registration is centred on x 195 (`ABC 88` ink runs
///   63.6–325.6, `ABC 888` 40.6–348.4).
/// * vintage byline `VINTAGE VEHICLE` ink x 98.0–291.4, year 317.4–361.5, both
///   y 114.9–130.5.
///
/// Motorcycle (`Motor_plate_*`, `REGION_*`, `321NBC`, `GOVERNMENT`):
/// * ink y 36.5..96.8 (60.3 tall); six cells, ink 12.4–39.8 … 192.9–220.7,
///   pitch 36.1;
/// * a top strip runs from the edge to y 34.0, a bottom strip from y 101.0 to
///   the edge; both are cut by a field-coloured gap x 100.5–134.5 (where the
///   QR code sits on the top edge).
///
/// `glyphStyle` sets the font at 0.72 of the slot and a bold cap is ~0.76 of
/// that, so ink is ~0.55 of a slot. The reference face is condensed (cap
/// width ≈ 0.47 of its height) and DejaVu Sans Bold is not (≈ 0.7), so at the
/// measured pitch a full-height glyph overflows its cell and is scaled down on
/// its own, leaving T and 1 taller than N and B. The slots are capped where N
/// still fits, so a row stays one height: rendered car ink 43.2 of the
/// reference 72 (60%), motorcycle 33.3 of 60.3 (55%), centred on the measured
/// ink centres (car y 70.1, motorcycle y 66.65). Pitch and horizontal extent
/// match the reference.
///
/// Not drawn: the per-plate QR code and the mounting slots.
abstract final class _Layout {
  // Car.
  static const double carWidth = 390;
  static const double carHeight = 140;
  static const double carCentre = 195;
  static const double carPitch = 46.25;
  static const double carSlotTop = 31;
  static const double carSlotHeight = 80;

  static const double bylineTop = 112;
  static const double bylineHeight = 21.4;
  static const double bylineLeft = 98;
  static const double bylineWidth = 193.4;

  /// 15.6 of cap ink / 0.55.
  static const double bylineGlyph = 28;
  static const double yearLeft = 316.5;
  static const double yearRight = 362.5;
  static const double yearTop = 108.7;

  // Motorcycle.
  static const double motoWidth = 235;
  static const double motoHeight = 135;
  static const double motoLeft = 8.2;
  static const double motoPitch = 36.1;
  static const double motoSlotTop = 35.6;
  static const double motoSlotHeight = 62;
  static const double stripTopEnd = 34;
  static const double stripBottomStart = 101;
  static const double stripGapLeft = 100.5;
  static const double stripGapRight = 134.5;
}

/// * [car] — `ABC 1234` on 390×140; the OMVSP vanity `ABC 123` and `ABC 12`
///   are the same plate with fewer digits.
/// * [vintage] — the car plate with a `VINTAGE VEHICLE <year>` byline.
/// * [diplomatic] — `001 1234`: a three-digit mission code and a serial.
/// * [motorcycle] — six alphanumeric characters on 235×135, with or without a
///   region strip.
///
/// Private, electric/hybrid, public utility, government and diplomatic plates
/// differ only in colour: pass the matching `PhilippinesThemes` livery.
///
/// The 2014 series (region caption under the serial, `MC`/`TC` trapezoid
/// motorcycle plates) and the 1981 series (`PILIPINAS`, Rizal Monument) are
/// still on the road but no longer issued, and are not implemented.
abstract final class PhilippinesPlates {
  static const List<int> carDigitLengths = <int>[2, 3, 4];

  static final Map<int, PlateSpec> _cars = <int, PlateSpec>{};
  static final Map<String, PlateSpec> _motorcycles = <String, PlateSpec>{};

  /// `ABC 1234`, or the vanity `ABC 123` / `ABC 12`. Groups `letters`,
  /// `number`.
  static PlateSpec car({int digits = 4}) {
    if (!carDigitLengths.contains(digits)) {
      throw ArgumentError.value(digits, 'digits', 'is 2, 3 or 4');
    }
    return _cars[digits] ??= PlateSpec(
      id: 'ph.car.$digits',
      country: PhilippinesCountry.philippines,
      canvasWidth: _Layout.carWidth,
      canvasHeight: _Layout.carHeight,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.carHeight)),
      slots: _carRow(PhilippinesAlphabets.letters, digits),
      textGroups: _carGroups('letters', 'number', digits),
      resolveRegion: PhilippinesRegions.captionOf,
    );
  }

  /// `NTX 1006` over `VINTAGE VEHICLE 1965`. Groups `letters`, `number`,
  /// `year`.
  static final PlateSpec vintage = PlateSpec(
    id: 'ph.vintage',
    country: PhilippinesCountry.philippines,
    canvasWidth: _Layout.carWidth,
    canvasHeight: _Layout.carHeight,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.carHeight)),
    slots: <PlateSlot>[
      ..._carRow(PhilippinesAlphabets.letters, 4),
      ...plateRegisterAcross(
        alphabet: PhilippinesAlphabets.digits,
        count: 4,
        left: _Layout.yearLeft,
        right: _Layout.yearRight,
        top: _Layout.yearTop,
        height: _Layout.bylineGlyph,
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'VINTAGE VEHICLE',
        box: PlateBox(
          _Layout.bylineLeft,
          _Layout.bylineTop,
          _Layout.bylineWidth,
          _Layout.bylineHeight,
        ),
        glyphHeight: _Layout.bylineGlyph,
      ),
    ],
    textGroups: <PlateTextGroup>[
      ..._carGroups('letters', 'number', 4),
      const PlateTextGroup(<int>[7, 8, 9, 10], key: 'year'),
    ],
  );

  /// `001 1234`: mission code, serial. Groups `mission`, `serial`. Code
  /// `036` is refused; see [PhilippinesMissions].
  static final PlateSpec diplomatic = PlateSpec(
    id: 'ph.diplomatic',
    country: PhilippinesCountry.philippines,
    canvasWidth: _Layout.carWidth,
    canvasHeight: _Layout.carHeight,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.carHeight)),
    slots: _carRow(PhilippinesAlphabets.digits, 4),
    textGroups: _carGroups('mission', 'serial', 4),
    restrictions: const <PlateRestriction>[PhilippinesMissions.restriction],
  );

  /// Six characters, any mix of letters and digits (`123NBC`, `N123BC`…), on
  /// a plain face or with [strip]. Group `serial`.
  static PlateSpec motorcycle({PhilippinesStrip? strip}) {
    final String id = strip == null
        ? 'ph.motorcycle'
        : 'ph.motorcycle.${strip.id}';
    return _motorcycles[id] ??= PlateSpec(
      id: id,
      country: PhilippinesCountry.philippines,
      canvasWidth: _Layout.motoWidth,
      canvasHeight: _Layout.motoHeight,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.motoHeight)),
      background: strip == null ? PlateSection.plain : _stripped(strip),
      slots: plateRegister(
        alphabet: PhilippinesAlphabets.alphanumeric,
        count: 6,
        left: _Layout.motoLeft,
        top: _Layout.motoSlotTop,
        width: _Layout.motoPitch,
        height: _Layout.motoSlotHeight,
      ),
      textGroups: const <PlateTextGroup>[
        PlateTextGroup(<int>[0, 1, 2, 3, 4, 5], key: 'serial'),
      ],
    );
  }

  /// Three cells of [first], an empty cell, then [digits] digit cells, all at
  /// one pitch and centred on the plate.
  static List<PlateSlot> _carRow(PlateAlphabet first, int digits) {
    final double left = _Layout.carCentre - (4 + digits) * _Layout.carPitch / 2;
    return <PlateSlot>[
      ...plateRegister(
        alphabet: first,
        count: 3,
        left: left,
        top: _Layout.carSlotTop,
        width: _Layout.carPitch,
        height: _Layout.carSlotHeight,
      ),
      ...plateRegister(
        alphabet: PhilippinesAlphabets.digits,
        count: digits,
        left: left + 4 * _Layout.carPitch,
        top: _Layout.carSlotTop,
        width: _Layout.carPitch,
        height: _Layout.carSlotHeight,
      ),
    ];
  }

  static List<PlateTextGroup> _carGroups(
    String first,
    String second,
    int digits,
  ) => <PlateTextGroup>[
    PlateTextGroup(const <int>[0, 1, 2], key: first),
    PlateTextGroup(<int>[for (int i = 3; i < 3 + digits; i++) i], key: second),
  ];

  /// The strip along its edge, cut by a field gap at the centre.
  static PlateSection _stripped(PhilippinesStrip strip) {
    final PlateSection band = PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(strip.color)),
        end: _Layout.stripGapLeft,
      ),
      const PlatePart(PlateSection.plain, end: _Layout.stripGapRight),
      PlatePart(PlateSection.fill(PlateFill.color(strip.color))),
    ]);
    return switch (strip.edge) {
      PhilippinesStripEdge.top => PlateSection.rows(<PlatePart>[
        PlatePart(band, end: _Layout.stripTopEnd),
        const PlatePart(PlateSection.plain),
      ]),
      PhilippinesStripEdge.bottom => PlateSection.rows(<PlatePart>[
        const PlatePart(PlateSection.plain, end: _Layout.stripBottomStart),
        PlatePart(band),
      ]),
    };
  }
}
