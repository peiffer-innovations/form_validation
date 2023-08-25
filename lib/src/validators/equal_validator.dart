import 'package:form_validation/src/translations/form_validation_translations.dart';
import 'package:form_validation/src/validators/value_validator.dart';
import 'package:meta/meta.dart';

@immutable
class EqualValidator implements ValueValidator {
  /// Constructs the validator with the target [String] that the value must be.
  const EqualValidator({
    required this.target,
  }) : assert(target != '');

  static const kType = 'equal';

  final String target;

  @override
  String get type => kType;

  /// Processes the validator object from the given [map] which must be an
  /// actual Map or a Map-like object that supports the `[]` operator.  Any
  /// non-null object that is not Map-like will result in an error.  A `null`
  /// value will result in a return value of `null`.
  ///
  /// This expects the JSON format:
  /// ```json
  /// {
  ///   "target": <String>,
  ///   "type": "equal"
  /// }
  /// ```
  static EqualValidator fromDynamic(dynamic map) {
    EqualValidator result;

    if (map == null) {
      throw Exception('[EqualValidator.fromDynamic]: map is null');
    } else {
      assert(map['type'] == kType);

      result = EqualValidator(target: map['target']);
    }

    return result;
  }

  /// Returns the JSON-compatible representation of this validator.
  @override
  Map<String, dynamic> toJson() => {'target': target, 'type': type};

  /// Ensures the value contains at most [number] characters.
  ///
  /// This will pass on empty or `null` values.
  ///
  /// See also:
  ///  * [FormValidationTranslations.form_validation_equal]
  @override
  String? validate({
    required String label,
    required String? value,
  }) {
    String? error;

    if (value?.isNotEmpty == true) {
      if (value != target) {
        error = translate(FormValidationTranslations.form_validation_equal, {
          'label': label,
          'target': target,
        });
      }
    }

    return error;
  }
}
