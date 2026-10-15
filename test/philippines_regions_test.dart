import 'package:flutter_test/flutter_test.dart';
import 'package:philippines_plate/philippines_plate.dart';

void main() {
  test('leading letters resolve', () {
    expect(PhilippinesRegions.lookup('N'), 'Metro Manila');
    expect(PhilippinesRegions.lookup('d'), 'Calabarzon');
    expect(PhilippinesRegions.captionOf((_) => 'ZAB'), 'Caraga');
  });

  test('empty and government letters are null', () {
    expect(PhilippinesRegions.lookup(''), isNull);
    expect(PhilippinesRegions.lookup('S'), isNull);
    expect(PhilippinesRegions.captionOf((_) => ''), isNull);
  });
}
