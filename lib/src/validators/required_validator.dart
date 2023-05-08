import 'package:form_validation/form_validation.dart';
import 'package:json_class/json_class.dart';
import 'package:meta/meta.dart';

/// A validator that ensures the value is non-`null` and non-empty.
@immutable
class RequiredValidator extends JsonClass implements ValueValidator {
  static const type = 'required';

  /// Processes the validator object from the given [map] which must be an
  /// actual Map or a Map-like object that supports the `[]` operator.  Any
  /// non-null object that is not Map-like will result in an error.  A `null`
  /// value will result in a return value of `null`.
  ///
  /// This expects the JSON format:
  /// ```json
  /// {
  ///   "type": "required"
  /// }
  /// ```
  static RequiredValidator fromDynamic(dynamic map) {
    RequiredValidator result;

    if (map == null) {
      throw Exception('[RequiredValidator.fromDynamic]: map is null');
    } else {
      assert(map['type'] == type);

      result = RequiredValidator();
    }

    return result;
  }

  /// Returns the JSON-compatible representation of this validator.
  @override
  Map<String, dynamic> toJson() => {
        'type': type,
      };

  /// Passes non-empty values and fails on `null`, empty, or whitespace-only
  /// values.
  ///
  /// See also:
  ///  * [FormValidationTranslations.form_validation_required]
  @override
  String? validate({
    required String label,
    required String? value,
  }) {
    String? error;

    if (value?.trim().isNotEmpty != true) {
      error = translate(
        FormValidationTranslations.form_validation_required,
        {
          'label': label,
        },
      );
    }

    return error;
  }
}
