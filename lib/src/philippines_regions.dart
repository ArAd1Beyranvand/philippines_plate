import 'package:plate_core/plate_core.dart';

/// Locates a Philippine car plate from its leading letter.
///
/// Source: the "Registration area prefixes" table of
/// https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_the_Philippines
/// (`S`, reserved for government vehicles, names no region).
abstract final class PhilippinesRegions {
  static const Map<String, String> _regions = <String, String>{
    'A': 'Ilocos Region',
    'B': 'Cagayan Valley',
    'C': 'Central Luzon',
    'D': 'Calabarzon',
    'E': 'Bicol Region',
    'F': 'Western Visayas',
    'G': 'Central Visayas',
    'H': 'Eastern Visayas',
    'I': 'Ilocos Region',
    'J': 'Zamboanga Peninsula',
    'K': 'Northern Mindanao',
    'L': 'Davao Region',
    'M': 'Soccsksargen',
    'N': 'Metro Manila',
    'O': 'Calabarzon',
    'P': 'Metro Manila',
    'Q': 'Metro Manila',
    'R': 'Central Luzon',
    'T': 'Metro Manila',
    'U': 'Metro Manila',
    'V': 'Mimaropa',
    'W': 'Central Luzon',
    'X': 'Metro Manila',
    'Y': 'Cordillera',
    'Z': 'Caraga',
  };

  /// The region of [letter], or null when empty or not a regional prefix.
  static String? lookup(String letter) => _regions[letter.toUpperCase()];

  /// A [PlateLabelResolver] for [PlateSpec.resolveRegion].
  static String? captionOf(String Function(String key) group) {
    final String letters = group('letters');
    return letters.isEmpty ? null : lookup(letters[0]);
  }
}
