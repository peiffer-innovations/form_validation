import 'package:form_validation/form_validation.dart';
import 'package:json_class/json_class.dart';
import 'package:meta/meta.dart';

@immutable
class MinLengthValidator extends JsonClass implements ValueValidator {
  /// Constructs the validator with the minimum [length] that the value must be.
  const MinLengthValidator({
    required this.length,
  }) : assert(length >= 0);

  static const kType = 'min_length';

  final int length;

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
  ///   "length": <number>,
  ///   "type": "min_length"
  /// }
  /// ```
  static MinLengthValidator fromDynamic(dynamic map) {
    MinLengthValidator result;

    if (map == null) {
      throw Exception('[MinLengthValidator.fromDynamic]: map is null');
    } else {
      assert(map['type'] == kType);

      result = MinLengthValidator(
        length: JsonClass.maybeParseInt(
              map['length'],
            ) ??
            0,
      );
    }

    return result;
  }

  /// Returns the JSON-compatible representation of this validator.
  @override
  Map<String, dynamic> toJson() => {
        'length': length,
        'type': type,
      };

  /// Ensures the value contains at least [number] characters.
  ///
  /// This will pass on empty or `null` values.
  ///
  /// See also:
  ///  * [FormValidationTranslations.form_validation_min_length]
  @override
  String? validate({
    required String label,
    required String? value,
  }) {
    String? error;

    if (value?.isNotEmpty == true) {
      if (value!.length < length) {
        error = translate(
          FormValidationTranslations.form_validation_min_length,
          {
            'label': label,
            'length': length,
          },
        );
      }
    }

    return error;
  }
}
