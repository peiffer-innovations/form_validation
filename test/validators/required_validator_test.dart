import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';
import 'package:static_translations/static_translations.dart';

const _kBuilder = RequiredValidator.fromDynamic;
const _kType = RequiredValidator.type;

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
      }) is RequiredValidator,
      true,
    );

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
    var translator = Translator.of(null);

    expect(
      RequiredValidator().validate(
        label: 'test',
        translator: translator,
        value: '8005556666',
      ),
      null,
    );
    expect(
      RequiredValidator().validate(
        label: 'test',
        translator: translator,
        value: '800-555-6666',
      ),
      null,
    );
    expect(
      RequiredValidator().validate(
        label: 'test',
        translator: translator,
        value: '(800) 555-6666',
      ),
      null,
    );
    expect(
      RequiredValidator().validate(
        label: 'test',
        translator: translator,
        value: '555-6666',
      ),
      null,
    );
    expect(
      RequiredValidator().validate(
        label: 'test',
        translator: translator,
        value: '+1 22 333 555 4444',
      ),
      null,
    );

    expect(
      RequiredValidator()
          .validate(
            label: 'test',
            translator: translator,
            value: null,
          )
          ?.isNotEmpty,
      true,
    );

    expect(
      RequiredValidator()
          .validate(
            label: 'test',
            translator: translator,
            value: '',
          )
          ?.isNotEmpty,
      true,
    );

    expect(
      RequiredValidator()
          .validate(
            label: 'test',
            translator: translator,
            value: '    ',
          )
          ?.isNotEmpty,
      true,
    );
  });
}
