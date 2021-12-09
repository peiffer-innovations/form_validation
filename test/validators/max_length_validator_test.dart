import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';
import 'package:static_translations/static_translations.dart';

const _kBuilder = MaxLengthValidator.fromDynamic;
const _kType = MaxLengthValidator.type;

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
        'length': 5,
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
        'length': -1,
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
        'length': 5,
        'type': _kType,
      }).length,
      5,
    );

    expect(MaxLengthValidator(length: 5).toJson(), {
      'length': 5,
      'type': _kType,
    });
  });

  testWidgets('validate', (tester) async {
    var translator = Translator.of(null);
    expect(
      MaxLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: null,
      ),
      null,
    );

    expect(
      MaxLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: '',
      ),
      null,
    );
    expect(
      MaxLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: '1',
      ),
      null,
    );
    expect(
      MaxLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: 'a',
      ),
      null,
    );
    expect(
      MaxLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: '12',
      ),
      null,
    );
    expect(
      MaxLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: '123ab',
      ),
      null,
    );

    expect(
      MaxLengthValidator(
        length: 5,
      )
          .validate(
            label: 'test',
            translator: translator,
            value: '123456',
          )
          ?.isNotEmpty,
      true,
    );
  });
}
