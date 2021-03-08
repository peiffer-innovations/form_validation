import 'package:form_validation/form_validation.dart';
import 'package:json_class/json_class.dart';
import 'package:meta/meta.dart';
import 'package:static_translations/static_translations.dart';

@immutable
class NumberValidator extends JsonClass implements ValueValidator {
  /// Constructs the validator with the option to allow decimal values or
  /// restrict to integer only.
  NumberValidator({
    this.allowDecimal = true,
  });

  static const type = 'number';

  final bool allowDecimal;

  /// Processes the validator object from the given [map] which must be an
  /// actual Map or a Map-like object that supports the `[]` operator.  Any
  /// non-null object that is not Map-like will result in an error.  A [null]
  /// value will result in a return value of [null].
  ///
  /// This expects the JSON format:
  /// ```json
  /// {
  ///   "allowDecimal": <bool>
  ///   "type": "number"
  /// }
  /// ```
  static NumberValidator fromDynamic(dynamic map) {
    NumberValidator result;

    if (map == null) {
      throw Exception('[NumberValidator.fromDynamic]: map is null');
    } else {
      assert(map['type'] == type);

      result = NumberValidator(
        allowDecimal: map['allowDecimal'] == null
            ? true
            : JsonClass.parseBool(map['allowDecimal']),
      );
    }

    return result;
  }

  /// Returns the JSON-compatible representation of this validator.
  @override
  Map<String, dynamic> toJson() => {
        'allowDecimal': allowDecimal,
        'type': type,
      };

  /// Ensures the value is a valid number.  If [allowDecimal] is [true] then
  /// this will allow non-integer values.  Otherwise, this will fail on
  /// non-integer values.
  ///
  /// This will pass on empty or [null] values.
  ///
  /// See also:
  ///  * [FormValidationTranslations.form_validation_number]
  ///  * [FormValidationTranslations.form_validation_number_decimal]
  @override
  String? validate({
    required String label,
    required Translator translator,
    required String? value,
  }) {
    String? error;

    if (value?.isNotEmpty == true) {
      var numValue = JsonClass.parseDouble(value);

      if (numValue == null) {
        error = translator.translate(
          FormValidationTranslations.form_validation_number,
          {
            'label': label,
          },
        );
      } else if (allowDecimal != true && numValue.toInt() != numValue) {
        error = translator.translate(
          FormValidationTranslations.form_validation_number_decimal,
          {
            'label': label,
          },
        );
      }
    }

    return error;
  }
}
