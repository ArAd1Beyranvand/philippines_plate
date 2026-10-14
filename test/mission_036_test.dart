import 'package:flutter_test/flutter_test.dart';
import 'package:philippines_plate/philippines_plate.dart';
import 'package:plate_core/plate_core.dart';

/// Code 036 must be refused in every layer, always with "COUNTRY NOT FOUND".
void main() {
  const notFound = 'COUNTRY NOT FOUND';
  final spec = PhilippinesPlates.diplomatic;
  List<String?> values(String s) =>
      s.split('').map((c) => c == '_' ? null : c).toList();

  test('registry: name() throws, all omits it', () {
    expect(
      () => PhilippinesMissions.name('036'),
      throwsA(isA<PlateRestrictionException>()),
    );
    expect(PhilippinesMissions.all.containsKey('036'), isFalse);
    expect(PhilippinesMissions.name('002'), isNotNull);
  });

  test('spec: restriction is declared and checkRestrictions throws', () {
    expect(spec.restrictions, contains(PhilippinesMissions.restriction));
    expect(spec.restrictionViolatedBy(values('0361234'))?.reason, notFound);
    expect(
      () => spec.checkRestrictions(values('0361234')),
      throwsA(isA<PlateRestrictionException>()),
    );
  });

  test('controller: setAt / setValues / setGroup refuse 036', () {
    final c = PlateController.fromValues(spec, values('03_1234'));
    expect(c.setAt(2, '6'), isFalse);
    expect(c.valueAt(2), isNull);
    expect(c.rejection.value?.reason, notFound);
    expect(c.setValues(values('0361234')), isFalse);
    expect(c.setGroup('mission', '036'), isFalse);
    expect(c.setAt(2, '5'), isTrue);
    expect(c.rejection.value, isNull);
    c.dispose();
  });

  test('validator reports it, even on a spec without the restriction', () {
    final entry = PlateEntry(spec: spec, values: values('0361234'));
    expect(
      const PhilippinesDiplomaticValidator().validate(entry).reason,
      notFound,
    );
    final bare = PlateSpec(
      id: 'bare',
      country: spec.country,
      canvasWidth: spec.canvasWidth,
      canvasHeight: spec.canvasHeight,
      panel: spec.panel,
      slots: spec.slots,
      textGroups: spec.textGroups,
    );
    expect(
      const PhilippinesDiplomaticValidator()
          .validate(PlateEntry(spec: bare, values: values('0361234')))
          .reason,
      notFound,
    );
  });

  test('a listed mission validates', () {
    final entry = PlateEntry(spec: spec, values: values('0020020'));
    expect(
      const PhilippinesDiplomaticValidator().validate(entry).isValid,
      isTrue,
    );
  });
}
