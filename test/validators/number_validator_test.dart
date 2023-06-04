import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';

const _kBuilder = NumberValidator.fromDynamic;
const _kType = NumberValidator.kType;

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
        'allowDecimal': true,
        'type': _kType,
      },
    );

    expect(const NumberValidator().toJson(), {
      'allowDecimal': true,
      'type': _kType,
    });

    expect(const NumberValidator(allowDecimal: true).toJson(), {
      'allowDecimal': true,
      'type': _kType,
    });

    expect(const NumberValidator(allowDecimal: false).toJson(), {
      'allowDecimal': false,
      'type': _kType,
    });
  });

  testWidgets('validate', (tester) async {
    expect(
      const NumberValidator().validate(
        label: 'test',
        value: null,
      ),
      null,
    );

    expect(
      const NumberValidator().validate(
        label: 'test',
        value: '',
      ),
      null,
    );
    expect(
      const NumberValidator().validate(
        label: 'test',
        value: '1',
      ),
      null,
    );
    expect(
      const NumberValidator().validate(
        label: 'test',
        value: '1.0',
      ),
      null,
    );
    expect(
      const NumberValidator().validate(
        label: 'test',
        value: '1.01',
      ),
      null,
    );
    expect(
      const NumberValidator().validate(
        label: 'test',
        value: '-1.0',
      ),
      null,
    );
    expect(
      const NumberValidator(
        allowDecimal: false,
      ).validate(
        label: 'test',

        value: '1.0', // this resolves to an int because the decimal value is 0.
      ),
      null,
    );

    expect(
      const NumberValidator()
          .validate(
            label: 'test',
            value: 'foobar',
          )
          ?.isNotEmpty,
      true,
    );

    expect(
      const NumberValidator(
        allowDecimal: false,
      )
          .validate(
            label: 'test',
            value: '1.01',
          )
          ?.isNotEmpty,
      true,
    );
    expect(
      const NumberValidator()
          .validate(
            label: 'test',
            value: 'foo',
          )
          ?.isNotEmpty,
      true,
    );
  });
}
