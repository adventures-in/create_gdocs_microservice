import 'package:create_gdocs_microservice/src/extensions/int_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('IntExtension', () {
    test('asValue() returns expected Value', () {
      final exampleInt = 10;

      final value = exampleInt.asValue();

      expect(value.integerValue, exampleInt.toString());
    });
  });
}
