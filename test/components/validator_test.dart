import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';
import 'package:static_translations/static_translations.dart';

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

    var jsonStr = '''
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

    var validator = Validator.fromDynamic(json.decode(jsonStr));
    var expectedTypes = [
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
        _MyNumberValidator.type,
        _MyNumberValidator.fromDynamic,
      );
      Validator.registerCustomValidatorBuilder(
        _MyMockValidator.type,
        _MyMockValidator.fromDynamic,
      );
    });
    tearDown(() {
      Validator.unregisterCustomValidatorBuilder(_MyNumberValidator.type);
      Validator.unregisterCustomValidatorBuilder(_MyMockValidator.type);
    });
    test('custom', () {
      var jsonStr = '''
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

      var validator = Validator.fromDynamic(json.decode(jsonStr));
      var expectedTypes = [
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
    var label = 'test';
    var length = 8;
    var translator = Translator.of(null);
    var validator = Validator(validators: [
      RequiredValidator(),
      MinLengthValidator(length: length),
      EmailValidator(),
    ]);

    expect(
      validator.validate(
        context: null,
        label: 'test',
        translator: translator,
        value: '',
      ),
      translator.translate(
        FormValidationTranslations.form_validation_required,
        {
          'label': label,
        },
      ),
    );
    expect(
      validator.validate(
        context: null,
        label: 'test',
        translator: translator,
        value: 'test',
      ),
      translator.translate(
        FormValidationTranslations.form_validation_min_length,
        {
          'label': label,
          'length': length,
        },
      ),
    );

    expect(
      validator.validate(
        context: null,
        label: 'test',
        translator: translator,
        value: 'testtest',
      ),
      translator.translate(
        FormValidationTranslations.form_validation_email,
        {
          'label': label,
        },
      ),
    );

    expect(
      validator.validate(
        context: null,
        label: 'test',
        translator: translator,
        value: 'test@test.com',
      ),
      null,
    );
  });
}

class _MyMockValidator extends ValueValidator {
  static const type = 'mock';

  static _MyMockValidator fromDynamic(dynamic map) {
    _MyMockValidator result;

    if (map == null) {
      throw Exception('map is null');
    } else {
      assert(map['type'] == type);

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
    required Translator translator,
    required String? value,
  }) =>
      null;
}

class _MyNumberValidator extends ValueValidator {
  static const type = 'number';

  static _MyNumberValidator fromDynamic(dynamic map) {
    _MyNumberValidator result;

    if (map == null) {
      throw Exception('map is null');
    } else {
      assert(map['type'] == type);

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
    required Translator translator,
    required String? value,
  }) =>
      null;
}
