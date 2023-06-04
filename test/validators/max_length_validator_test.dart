import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';

const _kBuilder = MaxLengthValidator.fromDynamic;
const _kType = MaxLengthValidator.kType;

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

    expect(const MaxLengthValidator(length: 5).toJson(), {
      'length': 5,
      'type': _kType,
    });
  });

  testWidgets('validate', (tester) async {
    expect(
      const MaxLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        value: null,
      ),
      null,
    );

    expect(
      const MaxLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        value: '',
      ),
      null,
    );
    expect(
      const MaxLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        value: '1',
      ),
      null,
    );
    expect(
      const MaxLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        value: 'a',
      ),
      null,
    );
    expect(
      const MaxLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        value: '12',
      ),
      null,
    );
    expect(
      const MaxLengthValidator(
        length: 5,
      ).validate(
        label: 'test',
        value: '123ab',
      ),
      null,
    );

    expect(
      const MaxLengthValidator(
        length: 5,
      )
          .validate(
            label: 'test',
            value: '123456',
          )
          ?.isNotEmpty,
      true,
    );
  });
}
