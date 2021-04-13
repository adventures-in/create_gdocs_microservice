import 'package:create_gdocs_microservice/src/extensions/string_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('StringExtension', () {
    test('asValue() returns expected Value', () {
      final exampleString = 'asdf';

      final value = exampleString.asValue();

      expect(value.stringValue, exampleString);
    });
  });
}
