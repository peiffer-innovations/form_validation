import 'package:form_validation/form_validation.dart';
import 'package:json_class/json_class.dart';
import 'package:meta/meta.dart';
import 'package:static_translations/static_translations.dart';

@immutable
class MinNumberValidator extends JsonClass implements ValueValidator {
  /// Constructs the validator with the minimum [number] that the value must be.
  MinNumberValidator({
    @required this.number,
  }) : assert(number > 0);

  static const type = 'min_number';

  final double number;

  /// Processes the validator object from the given [map] which must be an
  /// actual Map or a Map-like object that supports the `[]` operator.  Any
  /// non-null object that is not Map-like will result in an error.  A [null]
  /// value will result in a return value of [null].
  ///
  /// This expects the JSON format:
  /// ```json
  /// {
  ///   "number": <number>,
  ///   "type": "min_number"
  /// }
  /// ```
  static MinNumberValidator fromDynamic(dynamic map) {
    MinNumberValidator result;

    if (map != null) {
      assert(map['type'] == type);

      result = MinNumberValidator(
        number: JsonClass.parseDouble(
          map['number'],
        ),
      );
    }

    return result;
  }

  /// Returns the JSON-compatible representation of this validator.
  @override
  Map<String, dynamic> toJson() => {
        'number': number,
        'type': type,
      };

  /// Ensures the value is a valid number that is at least as large as the
  /// assigned [number].
  ///
  /// This will pass on empty or [null] values.
  ///
  /// See also:
  ///  * [FormValidationTranslations.form_validation_min_number]
  ///  * [FormValidationTranslations.form_validation_number]
  @override
  String validate({
    @required String label,
    @required Translator translator,
    @required String value,
  }) {
    assert(label?.isNotEmpty == true);

    String error;

    if (value?.isNotEmpty == true) {
      var numValue = JsonClass.parseDouble(value);

      if (numValue == null) {
        error = translator.translate(
          FormValidationTranslations.form_validation_number,
          {
            'label': label,
          },
        );
      } else if (numValue < number) {
        error = translator.translate(
          FormValidationTranslations.form_validation_min_number,
          {
            'label': label,
            'number': number,
          },
        );
      }
    }

    return error;
  }
}
