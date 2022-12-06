import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';
import 'package:static_translations/static_translations.dart';

const _kBuilder = MinLengthValidator.fromDynamic;
const _kType = MinLengthValidator.type;

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

    expect(MinLengthValidator(length: 5).toJson(), {
      'length': 5,
      'type': _kType,
    });
  });

  testWidgets('validate', (tester) async {
    final translator = Translator.of(null);
    expect(
      MinLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: null,
      ),
      null,
    );

    expect(
      MinLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: '',
      ),
      null,
    );
    expect(
      MinLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: '123456',
      ),
      null,
    );
    expect(
      MinLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: 'abcdefghijklmnopqrstuvwxyz',
      ),
      null,
    );
    expect(
      MinLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        translator: translator,
        value: '12345',
      ),
      null,
    );

    expect(
      MinLengthValidator(
        length: 5,
      )
          .validate(
            label: 'test',
            translator: translator,
            value: '1234',
          )
          ?.isNotEmpty,
      true,
    );
  });
}
