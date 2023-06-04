import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';

const _kBuilder = CurrencyValidator.fromDynamic;
const _kType = CurrencyValidator.kType;

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
      }).allowNegative,
      true,
    );

    expect(
      _kBuilder({
        'allowNegative': false,
        'type': _kType,
      }).allowNegative,
      false,
    );

    expect(
      _kBuilder({
        'allowNegative': true,
        'type': _kType,
      }).allowNegative,
      true,
    );

    expect(
      _kBuilder({
        'type': _kType,
      }).toJson(),
      {
        'allowNegative': true,
        'type': _kType,
      },
    );

    expect(const CurrencyValidator().toJson(), {
      'allowNegative': true,
      'type': _kType,
    });

    expect(const CurrencyValidator(allowNegative: true).toJson(), {
      'allowNegative': true,
      'type': _kType,
    });

    expect(const CurrencyValidator(allowNegative: false).toJson(), {
      'allowNegative': false,
      'type': _kType,
    });
  });

  testWidgets('validate', (tester) async {
    expect(
      const CurrencyValidator().validate(
        label: 'test',
        value: null,
      ),
      null,
    );

    expect(
      const CurrencyValidator().validate(
        label: 'test',
        value: '',
      ),
      null,
    );
    expect(
      const CurrencyValidator().validate(
        label: 'test',
        value: '1',
      ),
      null,
    );
    expect(
      const CurrencyValidator().validate(
        label: 'test',
        value: '1.0',
      ),
      null,
    );
    expect(
      const CurrencyValidator().validate(
        label: 'test',
        value: '1.00',
      ),
      null,
    );
    expect(
      const CurrencyValidator().validate(
        label: 'test',
        value: '-1',
      ),
      null,
    );

    expect(
      const CurrencyValidator(
        allowNegative: false,
      )
          .validate(
            label: 'test',
            value: '-1',
          )
          ?.isNotEmpty,
      true,
    );
    expect(
      const CurrencyValidator()
          .validate(
            label: 'test',
            value: 'foo',
          )
          ?.isNotEmpty,
      true,
    );
  });
}
