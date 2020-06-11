import 'package:form_validation/form_validation.dart';
import 'package:json_class/json_class.dart';
import 'package:meta/meta.dart';
import 'package:static_translations/static_translations.dart';

@immutable
class MaxLengthValidator extends JsonClass implements ValueValidator {
  /// Constructs the validator with the maximum [length] that the value must be.
  MaxLengthValidator({
    @required this.length,
  })  : assert(length != null),
        assert(length > 0);

  static const type = 'max_length';

  final int length;

  /// Processes the validator object from the given [map] which must be an
  /// actual Map or a Map-like object that supports the `[]` operator.  Any
  /// non-null object that is not Map-like will result in an error.  A [null]
  /// value will result in a return value of [null].
  ///
  /// This expects the JSON format:
  /// ```json
  /// {
  ///   "length": <number>,
  ///   "type": "max_length"
  /// }
  /// ```
  static MaxLengthValidator fromDynamic(dynamic map) {
    MaxLengthValidator result;

    if (map != null) {
      assert(map['type'] == type);

      result = MaxLengthValidator(
        length: JsonClass.parseInt(
          map['length'],
        ),
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

  /// Ensures the value contains at most [number] characters.
  ///
  /// This will pass on empty or [null] values.
  ///
  /// See also:
  ///  * [FormValidationTranslations.form_validation_max_length]
  @override
  String validate({
    @required String label,
    @required Translator translator,
    @required String value,
  }) {
    assert(label?.isNotEmpty == true);

    String error;

    if (value?.isNotEmpty == true) {
      if (value.length > length) {
        error = translator.translate(
          FormValidationTranslations.form_validation_max_length,
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
