import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';
import 'package:static_translations/static_translations.dart';

const _kBuilder = MinNumberValidator.fromDynamic;
const _kType = MinNumberValidator.type;

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
        'number': 5,
      });
      fail('Expected exception');
    } catch (e) {
      // pass
    }

    try {
      _kBuilder({
        'type': _kType,
      });
      fail('Expected exception');
    } catch (e) {
      // pass
    }

    try {
      _kBuilder({
        'number': -1,
        'type': _kType,
      });
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
        'number': 5,
        'type': _kType,
      }) is MinNumberValidator,
      true,
    );

    expect(
      _kBuilder({
        'number': 5,
        'type': _kType,
      }).number,
      5,
    );

    expect(MinNumberValidator(number: 5).toJson(), {
      'number': 5,
      'type': _kType,
    });
  });

  testWidgets('validate', (tester) async {
    var translator = Translator.of(null);
    expect(
      MinNumberValidator(
        number: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: null,
      ),
      null,
    );

    expect(
      MinNumberValidator(
        number: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: '',
      ),
      null,
    );
    expect(
      MinNumberValidator(
        number: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: '5',
      ),
      null,
    );
    expect(
      MinNumberValidator(
        number: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: '10',
      ),
      null,
    );
    expect(
      MinNumberValidator(
        number: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: '5.0',
      ),
      null,
    );
    expect(
      MinNumberValidator(
        number: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: '6.1',
      ),
      null,
    );

    expect(
      MinNumberValidator(
        number: 5,
      )
          .validate(
            label: 'test',
            translator: translator,
            value: '4',
          )
          ?.isNotEmpty,
      true,
    );
    expect(
      MinNumberValidator(
        number: 5,
      )
          .validate(
            label: 'test',
            translator: translator,
            value: 'a',
          )
          ?.isNotEmpty,
      true,
    );
  });
}
