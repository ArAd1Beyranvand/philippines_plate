import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:philippines_plate/philippines_plate.dart';
import 'package:plate_core/plate_core.dart';

void main() {
  bool valid(PlateValidator v, PlateSpec spec, String s) =>
      v.validate(PlateEntry(spec: spec, values: s.split(''))).isValid;

  test('car', () {
    const v = PhilippinesValidator();
    expect(valid(v, PhilippinesPlates.car(), 'NBC1234'), isTrue);
    expect(valid(v, PhilippinesPlates.car(), 'NBC0000'), isFalse);
    expect(valid(v, PhilippinesPlates.car(), 'SAB1234'), isFalse);
    expect(
      valid(const PhilippinesValidator(government: true), PhilippinesPlates.car(), 'SAB1234'),
      isTrue,
    );
    expect(valid(v, PhilippinesPlates.car(digits: 2), 'ABC01'), isTrue);
  });

  test('vintage', () {
    const v = PhilippinesValidator();
    expect(valid(v, PhilippinesPlates.vintage, 'NTX10061965'), isTrue);
    expect(valid(v, PhilippinesPlates.vintage, 'NAB10061965'), isFalse);
  });

  test('motorcycle', () {
    const v = PhilippinesMotorcycleValidator();
    expect(valid(v, PhilippinesPlates.motorcycle(), '123ABC'), isTrue);
    expect(valid(v, PhilippinesPlates.motorcycle(), '123456'), isFalse);
  });

  test('generator output validates', () {
    final rnd = Random(1);
    final cases = <(PlateSpec, PlateValidator)>[
      (PhilippinesPlates.car(), const PhilippinesValidator()),
      (PhilippinesPlates.diplomatic, const PhilippinesDiplomaticValidator()),
      (PhilippinesPlates.motorcycle(), const PhilippinesMotorcycleValidator()),
    ];
    for (int i = 0; i < 50; i++) {
      for (final (spec, validator) in cases) {
        final values = PhilippinesSerialGenerator.generate(spec, random: rnd);
        expect(
          validator.validate(PlateEntry(spec: spec, values: values)).isValid,
          isTrue,
          reason: '${spec.id} $values',
        );
      }
    }
  });
}
