import 'package:form_validation/form_validation.dart';
import 'package:intl/intl.dart';
import 'package:json_class/json_class.dart';
import 'package:meta/meta.dart';
import 'package:static_translations/static_translations.dart';

/// Validator that ensures the value is a valid currency for the device's
/// current locale.
@immutable
class CurrencyValidator extends JsonClass implements ValueValidator {
  /// Constructs the validator with the option to [allowNegative] values or not.
  /// If [allowNegative] is [true] then this will allow negative values and will
  /// error out on negative otherwise.
  CurrencyValidator({
    this.allowNegative = true,
  }) : assert(allowNegative != null);

  static const type = 'currency';

  final bool allowNegative;

  /// Processes the validator object from the given [map] which must be an
  /// actual Map or a Map-like object that supports the `[]` operator.  Any
  /// non-null object that is not Map-like will result in an error.  A [null]
  /// value will result in a return value of [null].
  ///
  /// This expects the JSON format:
  /// ```json
  /// {
  ///   "allowNegative": <bool>,
  ///   "type": "currency"
  /// }
  /// ```
  static CurrencyValidator fromDynamic(dynamic map) {
    CurrencyValidator result;

    if (map != null) {
      assert(map['type'] == type);

      result = CurrencyValidator(
        allowNegative: map['allowNegative'] == null
            ? true
            : JsonClass.parseBool(map['allowNegative']),
      );
    }

    return result;
  }

  /// Returns the JSON-compatible representation of this validator.
  @override
  Map<String, dynamic> toJson() => {
        'allowNegative': allowNegative,
        'type': type,
      };

  /// Validates that the given value is in a valid currency format.  If
  /// [allowNegative] is [true] then this will pass on negative currency values,
  /// other this will fail on negative currency values.
  ///
  /// This will pass on empty or [null] values.
  ///
  /// See also:
  ///  * [FormValidationTranslations.form_validation_currency]
  ///  * [FormValidationTranslations.form_validation_currency_positive]
  @override
  String validate({
    @required String label,
    @required Translator translator,
    @required String value,
  }) {
    assert(label?.isNotEmpty == true);

    String error;

    if (value?.isNotEmpty == true) {
      double d;
      try {
        d = NumberFormat.currency().parse(value);
      } catch (e) {
        // no-op, it simply failed parsing
      }

      if (d == null) {
        error = translator.translate(
          FormValidationTranslations.form_validation_currency,
          {
            'label': label,
          },
        );
      } else if (d < 0 && allowNegative != true) {
        error = translator.translate(
          FormValidationTranslations.form_validation_currency_positive,
          {
            'label': label,
          },
        );
      }
    }

    return error;
  }
}
