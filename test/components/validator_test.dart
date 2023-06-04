import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';

void main() {
  test('json', () {
    try {
      expect(Validator.fromDynamic(null), null);
      fail('Exception expected');
    } catch (e) {
      // pass
    }

    try {
      Validator.fromDynamic({'validators': []});

      fail('Exception expected');
    } catch (e) {
      // pass
    }

    try {
      Validator.fromDynamic({
        'validators': [
          {'type': 'unknown'}
        ]
      });

      fail('Exception expected');
    } catch (e) {
      // pass
    }

    final jsonStr = '''
{
  "validators": [{
    "allowNegative": true,
    "type": "currency"
  }, {
    "type": "email"
  }, {
    "length": 5,
    "type": "max_length"
  }, {
    "number": 5,
    "type": "max_number"
  }, {
    "length": 5,
    "type": "min_length"
  }, {
    "number": 5,
    "type": "min_number"
  }, {
    "allowDecimal": true,
    "type": "number"
  }, {
    "type": "phone_number"
  }, {
    "type": "required"
  }]
}
''';

    final validator = Validator.fromDynamic(json.decode(jsonStr));
    final expectedTypes = [
      CurrencyValidator,
      EmailValidator,
      MaxLengthValidator,
      MaxNumberValidator,
      MinLengthValidator,
      MinNumberValidator,
      NumberValidator,
      PhoneNumberValidator,
      RequiredValidator,
    ];

    expect(validator.validators.length, expectedTypes.length);

    for (var i = 0; i < expectedTypes.length; i++) {
      expect(validator.validators[i].runtimeType == expectedTypes[i], true);
    }

    expect(json.decode(jsonStr), validator.toJson());
  });

  group('custom', () {
    setUp(() {
      Validator.registerCustomValidatorBuilder(
        _MyNumberValidator.kType,
        _MyNumberValidator.fromDynamic,
      );
      Validator.registerCustomValidatorBuilder(
        _MyMockValidator.kType,
        _MyMockValidator.fromDynamic,
      );
    });
    tearDown(() {
      Validator.unregisterCustomValidatorBuilder(_MyNumberValidator.kType);
      Validator.unregisterCustomValidatorBuilder(_MyMockValidator.kType);
    });
    test('custom', () {
      final jsonStr = '''
{
  "validators": [{
    "type": "required"
  }, {
    "type": "number"
  }, {
    "type": "mock"
  }]
}
''';

      final validator = Validator.fromDynamic(json.decode(jsonStr));
      final expectedTypes = [
        RequiredValidator,
        _MyNumberValidator,
        _MyMockValidator,
      ];
      expect(validator.validators.length, expectedTypes.length);

      for (var i = 0; i < expectedTypes.length; i++) {
        expect(validator.validators[i].runtimeType, expectedTypes[i]);
      }
    });
  });

  test('validate', () {
    final label = 'test';
    final length = 8;
    final validator = Validator(validators: [
      const RequiredValidator(),
      MinLengthValidator(length: length),
      const EmailValidator(),
    ]);

    expect(
      validator.validate(
        label: 'test',
        value: '',
      ),
      translate(
        FormValidationTranslations.form_validation_required,
        {
          'label': label,
        },
      ),
    );
    expect(
      validator.validate(
        label: 'test',
        value: 'test',
      ),
      translate(
        FormValidationTranslations.form_validation_min_length,
        {
          'label': label,
          'length': length,
        },
      ),
    );

    expect(
      validator.validate(
        label: 'test',
        value: 'testtest',
      ),
      translate(
        FormValidationTranslations.form_validation_email,
        {
          'label': label,
        },
      ),
    );

    expect(
      validator.validate(
        label: 'test',
        value: 'test@test.com',
      ),
      null,
    );
  });
}

class _MyMockValidator extends ValueValidator {
  static const kType = 'mock';

  @override
  String get type => kType;

  static _MyMockValidator fromDynamic(dynamic map) {
    _MyMockValidator result;

    if (map == null) {
      throw Exception('map is null');
    } else {
      assert(map['type'] == kType);

      result = _MyMockValidator();
    }

    return result;
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
      };

  @override
  String? validate({
    required String label,
    required String? value,
  }) =>
      null;
}

class _MyNumberValidator extends ValueValidator {
  static const kType = 'number';

  @override
  String get type => kType;

  static _MyNumberValidator fromDynamic(dynamic map) {
    _MyNumberValidator result;

    if (map == null) {
      throw Exception('map is null');
    } else {
      assert(map['type'] == kType);

      result = _MyNumberValidator();
    }

    return result;
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
      };

  @override
  String? validate({
    required String label,
    required String? value,
  }) =>
      null;
}
