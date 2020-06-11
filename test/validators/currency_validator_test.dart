import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';
import 'package:static_translations/static_translations.dart';

const _kBuilder = CurrencyValidator.fromDynamic;
const _kType = CurrencyValidator.type;

void main() {
  test('json', () {
    expect(_kBuilder(null), null);

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
      }) is CurrencyValidator,
      true,
    );

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

    expect(CurrencyValidator().toJson(), {
      'allowNegative': true,
      'type': _kType,
    });

    expect(CurrencyValidator(allowNegative: true).toJson(), {
      'allowNegative': true,
      'type': _kType,
    });

    expect(CurrencyValidator(allowNegative: false).toJson(), {
      'allowNegative': false,
      'type': _kType,
    });
  });

  testWidgets('validate', (tester) async {
    var translator = Translator.of(null);
    expect(
      CurrencyValidator().validate(
        label: 'test',
        translator: translator,
        value: null,
      ),
      null,
    );

    expect(
      CurrencyValidator().validate(
        label: 'test',
        translator: translator,
        value: '',
      ),
      null,
    );
    expect(
      CurrencyValidator().validate(
        label: 'test',
        translator: translator,
        value: '1',
      ),
      null,
    );
    expect(
      CurrencyValidator().validate(
        label: 'test',
        translator: translator,
        value: '1.0',
      ),
      null,
    );
    expect(
      CurrencyValidator().validate(
        label: 'test',
        translator: translator,
        value: '1.00',
      ),
      null,
    );
    expect(
      CurrencyValidator().validate(
        label: 'test',
        translator: translator,
        value: '-1',
      ),
      null,
    );

    expect(
      CurrencyValidator(
        allowNegative: false,
      )
          .validate(
            label: 'test',
            translator: translator,
            value: '-1',
          )
          ?.isNotEmpty,
      true,
    );
    expect(
      CurrencyValidator()
          .validate(
            label: 'test',
            translator: translator,
            value: 'foo',
          )
          ?.isNotEmpty,
      true,
    );
  });
}
