import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';

const _kBuilder = EmailValidator.fromDynamic;
const _kType = EmailValidator.kType;

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
      const EmailValidator().validate(
        label: 'test',
        value: null,
      ),
      null,
    );

    expect(
      const EmailValidator().validate(
        label: 'test',
        value: '',
      ),
      null,
    );
    expect(
      const EmailValidator().validate(
        label: 'test',
        value: 'peifferinnovations@gmail.com',
      ),
      null,
    );
    expect(
      const EmailValidator().validate(
        label: 'test',
        value: 'foo@bar.co',
      ),
      null,
    );

    expect(
      const EmailValidator()
          .validate(
            label: 'test',
            value: 'foobar',
          )
          ?.isNotEmpty,
      true,
    );
  });
}
