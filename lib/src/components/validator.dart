import 'package:form_validation/form_validation.dart';
import 'package:json_class/json_class.dart';

/// Container class for a series of [ValueValidator] objects.  Each
/// [ValueValidator] will be evaluated in a short-circuited way such that as
/// soon as one returns an error evaluation will immediately be stopped and the
/// error will be returned.
///
/// This has a set of built-in validators that it can decode and supports
/// applications adding their own custom validator builders.
///
/// See also:
///  * [fromDynamic]
///  * [registerCustomValidatorBuilder]
class Validator extends JsonClass {
  Validator({
    required this.validators,
  });

  static const _validatorBuilders = <String, JsonClassBuilder<ValueValidator>>{
    CurrencyValidator.type: CurrencyValidator.fromDynamic,
    EmailValidator.type: EmailValidator.fromDynamic,
    MaxLengthValidator.type: MaxLengthValidator.fromDynamic,
    MaxNumberValidator.type: MaxNumberValidator.fromDynamic,
    MinLengthValidator.type: MinLengthValidator.fromDynamic,
    MinNumberValidator.type: MinNumberValidator.fromDynamic,
    NumberValidator.type: NumberValidator.fromDynamic,
    PhoneNumberValidator.type: PhoneNumberValidator.fromDynamic,
    RequiredValidator.type: RequiredValidator.fromDynamic,
  };

  static final _customValidatorBuilders =
      <String, JsonClassBuilder<ValueValidator>>{};

  final List<ValueValidator> validators;

  /// Processes the list of [ValueValidator] objects from the given [map] which
  /// must be an actual Map or a Map-like object that supports the `[]`
  /// operator.  Any object that is not Map-like will result in an error.
  ///
  /// When attempting to build a validator, this will first check the list of
  /// custom validator builders and then check the list of internal validator
  /// builders.  This allows applications the ability to override even the built
  /// in default types.
  ///
  /// This expects a JSON object that looks like:
  /// ```json
  /// {
  ///   "validators": [
  ///     {
  ///       "type": "<type>"
  ///     },
  ///     ...
  ///   ]
  /// }
  /// ```
  ///
  /// See also:
  ///
  ///  * [CurrencyValidator], ensures the value represents a currency.
  ///  * [EmailValidator],  ensures the value is a valid email address format.
  ///  * [MaxLengthValidator], ensures the value has at most N characters.
  ///  * [MaxNumberValidator], ensures the value is a number no larger than N.
  ///  * [MinLengthValidator], ensures the value has at least N characters.
  ///  * [MinNumberValidator], ensures the value is a number no smaller than N.
  ///  * [NumberValidator], ensures the value is a valid number.
  ///  * [PhoneNumberValidator], ensures the value is formatted as a phone number.
  ///  * [RequiredValidator], ensures the value is not empty.
  ///
  /// Note: All validators except for [RequiredValidator] will pass on an empty
  /// value.
  static Validator fromDynamic(dynamic map) {
    late Validator result;

    if (map == null) {
      throw Exception('[Validator.fromDynamic]: map is null');
    } else {
      final list = map['validators'];
      final validators = <ValueValidator>[];
      if (list?.isNotEmpty == true) {
        for (var map in list) {
          final type = map['type'];
          final builder =
              _customValidatorBuilders[type] ?? _validatorBuilders[type];

          if (builder != null) {
            final validator = builder(map);
            validators.add(validator);
          } else {
            throw Exception('Unknown validator type: "$type');
          }
        }
        if (validators.isNotEmpty == true) {
          result = Validator(validators: validators);
        }
      }
    }

    return result;
  }

  /// Registers a custom validator [builder] for the given [type].  This will
  /// replace / overwrite any builder already registered for the given [type].
  static void registerCustomValidatorBuilder(
    String type,
    JsonClassBuilder<ValueValidator> builder,
  ) =>
      _customValidatorBuilders[type] = builder;

  /// Unregisters / removes a custom builder from the given [type].  This will
  /// do nothing if the [type] is not already registered.
  static void unregisterCustomValidatorBuilder(String type) =>
      _customValidatorBuilders.remove(type);

  /// Encodes this class into a JSON-compatible Map.
  @override
  Map<String, dynamic> toJson() => {
        'validators': JsonClass.toJsonList(validators),
      };

  /// Executes each of the [validators], in order.  This will fail-fast where
  /// it will stop walking the list as soon as any validator returns an error.
  ///
  /// A return value of `null` means all validators passed.  A non-null response
  /// is the error message that can be displayed to the user.
  ///
  /// The [context] is used to attempt to find a valid [Translator] on the
  /// widget tree.  This allows applications the ability to provide their own
  /// translated strings for error messages.
  ///
  /// See also:
  ///  * https://pub.dev/packages/static_translations
  String? validate({
    required String label,
    required String? value,
  }) {
    String? error;
    for (var v in validators) {
      error = v.validate(
        label: label,
        value: value,
      );

      if (error?.isNotEmpty == true) {
        break;
      }
    }

    // Normalize empty strings to `null` for API consistency.
    return error?.isEmpty == true ? null : error;
  }
}
