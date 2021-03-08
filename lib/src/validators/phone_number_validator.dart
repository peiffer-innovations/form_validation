import 'package:form_validation/form_validation.dart';
import 'package:json_class/json_class.dart';
import 'package:meta/meta.dart';
import 'package:static_translations/static_translations.dart';

/// Validator for phone numbers.
@immutable
class PhoneNumberValidator extends JsonClass implements ValueValidator {
  static const type = 'phone_number';

  /// Processes the validator object from the given [map] which must be an
  /// actual Map or a Map-like object that supports the `[]` operator.  Any
  /// non-null object that is not Map-like will result in an error.  A [null]
  /// value will result in a return value of [null].
  ///
  /// This expects the JSON format:
  /// ```json
  /// {
  ///   "type": "phone_number"
  /// }
  /// ```
  static PhoneNumberValidator fromDynamic(dynamic map) {
    PhoneNumberValidator result;

    if (map == null) {
      throw Exception('[PhoneNumberValidator.fromDynamic]: map is null');
    } else {
      assert(map['type'] == type);

      result = PhoneNumberValidator();
    }

    return result;
  }

  /// Returns the JSON-compatible representation of this validator.
  @override
  Map<String, dynamic> toJson() => {
        'type': type,
      };

  /// Ensures the value matches a properly formatted phone number.  This
  /// supports both US and international phone number formats.
  ///
  /// This will pass on empty or [null] values.
  ///
  /// See also:
  ///  * [FormValidationTranslations.form_validation_phone_number]
  @override
  String? validate({
    required String label,
    required Translator translator,
    required String? value,
  }) {
    String? error;

    if (value?.isNotEmpty == true) {
      // Credit to this SO answer: https://stackoverflow.com/a/16702965
      var pattern =
          r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';

      var regExp = RegExp(pattern);

      if (!regExp.hasMatch(value!)) {
        error = translator.translate(
          FormValidationTranslations.form_validation_phone_number,
          {
            'label': label,
          },
        );
      }
    }

    return error;
  }
}
