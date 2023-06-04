import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';

const _kBuilder = RequiredValidator.fromDynamic;
const _kType = RequiredValidator.kType;

void main() {
  test('json', () {
    try {
      expect(_kBuilder(null), null);
      fail('Expected exception');
    } catch (e) {
      // pass
    }

    try {
      _kBuilder({});
      fail('Expected exception');
    } catch (e) {
      // pass
    }

    try {
      _kBuilder({
        'type': 'foo',
      });
      fail('Expected exception');
    } catch (e) {
      // pass
    }

    expect(
      _kBuilder({
        'type': _kType,
      }).toJson(),
      {
        'type': _kType,
      },
    );
  });

  testWidgets('validate', (tester) async {
    expect(
      const RequiredValidator().validate(
        label: 'test',
        value: '8005556666',
      ),
      null,
    );
    expect(
      const RequiredValidator().validate(
        label: 'test',
        value: '800-555-6666',
      ),
      null,
    );
    expect(
      const RequiredValidator().validate(
        label: 'test',
        value: '(800) 555-6666',
      ),
      null,
    );
    expect(
      const RequiredValidator().validate(
        label: 'test',
        value: '555-6666',
      ),
      null,
    );
    expect(
      const RequiredValidator().validate(
        label: 'test',
        value: '+1 22 333 555 4444',
      ),
      null,
    );

    expect(
      const RequiredValidator()
          .validate(
            label: 'test',
            value: null,
          )
          ?.isNotEmpty,
      true,
    );

    expect(
      const RequiredValidator()
          .validate(
            label: 'test',
            value: '',
          )
          ?.isNotEmpty,
      true,
    );

    expect(
      const RequiredValidator()
          .validate(
            label: 'test',
            value: '    ',
          )
          ?.isNotEmpty,
      true,
    );
  });
}
