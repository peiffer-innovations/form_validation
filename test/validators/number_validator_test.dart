import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';
import 'package:static_translations/static_translations.dart';

const _kBuilder = NumberValidator.fromDynamic;
const _kType = NumberValidator.type;

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
      }) is NumberValidator,
      true,
    );

    expect(
      _kBuilder({
        'type': _kType,
      }).toJson(),
      {
        'allowDecimal': true,
        'type': _kType,
      },
    );

    expect(NumberValidator().toJson(), {
      'allowDecimal': true,
      'type': _kType,
    });

    expect(NumberValidator(allowDecimal: true).toJson(), {
      'allowDecimal': true,
      'type': _kType,
    });

    expect(NumberValidator(allowDecimal: false).toJson(), {
      'allowDecimal': false,
      'type': _kType,
    });
  });

  testWidgets('validate', (tester) async {
    var translator = Translator.of(null);
    expect(
      NumberValidator().validate(
        label: 'test',
        translator: translator,
        value: null,
      ),
      null,
    );

    expect(
      NumberValidator().validate(
        label: 'test',
        translator: translator,
        value: '',
      ),
      null,
    );
    expect(
      NumberValidator().validate(
        label: 'test',
        translator: translator,
        value: '1',
      ),
      null,
    );
    expect(
      NumberValidator().validate(
        label: 'test',
        translator: translator,
        value: '1.0',
      ),
      null,
    );
    expect(
      NumberValidator().validate(
        label: 'test',
        translator: translator,
        value: '1.01',
      ),
      null,
    );
    expect(
      NumberValidator().validate(
        label: 'test',
        translator: translator,
        value: '-1.0',
      ),
      null,
    );
    expect(
      NumberValidator(
        allowDecimal: false,
      ).validate(
        label: 'test',
        translator: translator,
        value: '1.0', // this resolves to an int because the decimal value is 0.
      ),
      null,
    );

    expect(
      NumberValidator()
          .validate(
            label: 'test',
            translator: translator,
            value: 'foobar',
          )
          ?.isNotEmpty,
      true,
    );

    expect(
      NumberValidator(
        allowDecimal: false,
      )
          .validate(
            label: 'test',
            translator: translator,
            value: '1.01',
          )
          ?.isNotEmpty,
      true,
    );
    expect(
      NumberValidator()
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
