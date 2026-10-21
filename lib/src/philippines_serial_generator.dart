import 'dart:math';

import 'package:plate_core/plate_core.dart';

import 'philippines_missions.dart';

/// Generates plausible values for fixtures and demos. Pure Dart.
///
/// Fills whichever of a Philippine spec's groups it carries: `letters` (no
/// leading S unless [government]), `number`, `year`, `mission` (a listed
/// code, never a refused one), `serial`. A motorcycle serial is the original
/// `123ABC` arrangement.
abstract final class PhilippinesSerialGenerator {
  static const String _alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  static List<String?> generate(
    PlateSpec spec, {
    Random? random,
    bool government = false,
  }) {
    final Random rnd = random ?? Random();
    final List<String?> values = List<String?>.filled(spec.slots.length, null);
    String letter() => _alphabet[rnd.nextInt(_alphabet.length)];
    String digit() => rnd.nextInt(10).toString();
    String leadingDigit(int i) => i == 0 ? '${1 + rnd.nextInt(9)}' : digit();
    void fill(String key, String Function(int i) pick) {
      final List<int> indices = spec.indicesOfGroup(key);
      for (int n = 0; n < indices.length; n++) {
        values[indices[n]] = pick(n);
      }
    }

    fill('letters', (i) {
      if (i > 0) return letter();
      if (government) return 'S';
      String first;
      do {
        first = letter();
      } while (first == 'S');
      return first;
    });
    fill('number', leadingDigit);
    fill('year', (i) => '${1950 + rnd.nextInt(40)}'[i]);
    final List<String> missions = PhilippinesMissions.all.keys.toList();
    final String mission = missions[rnd.nextInt(missions.length)];
    fill('mission', (i) => mission[i]);
    final bool diplomatic = spec.indicesOfGroup('mission').isNotEmpty;
    fill(
      'serial',
      (i) => diplomatic ? leadingDigit(i) : (i < 3 ? digit() : letter()),
    );
    return values;
  }
}
