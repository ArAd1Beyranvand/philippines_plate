import 'package:plate_core/plate_core.dart';

import 'philippines_missions.dart';

final RegExp _letters = RegExp(r'^[A-Z]+$');

/// Judges a `PhilippinesPlates.car` or `vintage` value. Reports, never bars a
/// keystroke; gated on the number.
///
/// Checks the series rules the article states: three letters; the digits are
/// never all zero (OMVSP excludes `00`, `000` and `0000`); a first letter `S`
/// is the government series, so a plate not marked [government] reports it.
/// On a `vintage` spec the letters end in TX, TY or TZ and the byline year is
/// four digits. Does not check which region a prefix belongs to: every letter
/// A–Z is allocated (S to none), so there is nothing to refuse.
class PhilippinesValidator extends GatedPlateValidator {
  const PhilippinesValidator({this.government = false});

  /// Whether the plate is a government (red) one, the only kind whose letters
  /// may start with S.
  final bool government;

  @override
  String get gateGroup => 'number';

  static const String reasonLetters = 'A plate starts with three letters.';
  static const String reasonNumber = 'The number is all digits.';
  static const String reasonZero = 'The number is never all zeros.';
  static const String reasonGovernment =
      'S is reserved for government vehicles.';
  static const String reasonVintage = 'A vintage plate ends in TX, TY or TZ.';
  static const String reasonYear = 'The year is four digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String letters = entry.group('letters');
    final String number = entry.group('number');
    if (letters.length != 3 || !_letters.hasMatch(letters)) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (!isDigits(number)) return const PlateValidation.invalid(reasonNumber);
    if (RegExp(r'^0+$').hasMatch(number)) {
      return const PlateValidation.invalid(reasonZero);
    }
    if (letters.startsWith('S') && !government) {
      return const PlateValidation.invalid(reasonGovernment);
    }
    if (entry.spec.indicesOfGroup('year').isNotEmpty) {
      if (!const <String>['TX', 'TY', 'TZ'].contains(letters.substring(1))) {
        return const PlateValidation.invalid(reasonVintage);
      }
      if (!isDigitsOfLength(entry.group('year'), 4)) {
        return const PlateValidation.invalid(reasonYear);
      }
    }
    return const PlateValidation.valid();
  }
}

/// Judges a `PhilippinesPlates.motorcycle` value: six characters with at least
/// one letter (the region letter) and one digit. The LTO issues "virtually any"
/// arrangement, so the order is not checked.
class PhilippinesMotorcycleValidator extends GatedPlateValidator {
  const PhilippinesMotorcycleValidator();

  @override
  String get gateGroup => 'serial';

  static const String reasonLength = 'A motorcycle plate has six characters.';
  static const String reasonMix =
      'A motorcycle plate mixes letters and digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String serial = entry.group('serial');
    if (serial.length != 6) return const PlateValidation.invalid(reasonLength);
    if (!RegExp('[A-Z]').hasMatch(serial) ||
        !RegExp('[0-9]').hasMatch(serial)) {
      return const PlateValidation.invalid(reasonMix);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a `PhilippinesPlates.diplomatic` value: a listed mission code and a
/// four-digit serial. Refuses `036` on its own account as well, so it holds
/// even against a spec built without [PhilippinesMissions.restriction].
class PhilippinesDiplomaticValidator extends GatedPlateValidator {
  const PhilippinesDiplomaticValidator();

  @override
  String get gateGroup => 'mission';

  static const String reasonSerial = 'The serial is four digits.';

  @override
  PlateValidation validate(PlateEntry entry) {
    if (PhilippinesMissions.isRefused(entry.group('mission'))) {
      return const PlateValidation.invalid(PhilippinesMissions.notFound);
    }
    return super.validate(entry);
  }

  @override
  PlateValidation judge(PlateEntry entry) {
    if (PhilippinesMissions.name(entry.group('mission')) == null) {
      return const PlateValidation.invalid(PhilippinesMissions.notFound);
    }
    if (!isDigitsOfLength(entry.group('serial'), 4)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}
