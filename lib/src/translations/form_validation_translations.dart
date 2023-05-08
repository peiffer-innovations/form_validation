import 'package:meta/meta.dart';

/// Translates the given entry.  Dynamic args must be surrounded in curley
/// braces.
String translate(
  String translated, [
  Map<String, dynamic>? args,
]) {
  args?.forEach((key, value) {
    translated = translated.replaceAll('{$key}', '$value');
  });

  return translated;
}

/// Provides the default (English) translations used by the library.
@immutable
class FormValidationTranslations {
  FormValidationTranslations._();

  static const _kDefaultInvalidError = '{label} is invalid';

  static final values = {
    'form_validation_currency': _kDefaultInvalidError,
    'form_validation_currency_positive': _kDefaultInvalidError,
    'form_validation_email': _kDefaultInvalidError,
    'form_validation_max_length':
        '{label} must contain at most {length} characters',
    'form_validation_max_number': '{label} must be at most {number}',
    'form_validation_min_length':
        '{label} must contain at least {length} characters',
    'form_validation_min_number': '{label} must be at least {number}',
    'form_validation_number': _kDefaultInvalidError,
    'form_validation_number_decimal': _kDefaultInvalidError,
    'form_validation_phone_number': _kDefaultInvalidError,
    'form_validation_required': '{label} is required',
  };

  static String get form_validation_currency =>
      values['form_validation_currency'] ?? _kDefaultInvalidError;
  static String get form_validation_currency_positive =>
      values['form_validation_currency_positive'] ?? _kDefaultInvalidError;
  static String get form_validation_email =>
      values['form_validation_email'] ?? _kDefaultInvalidError;
  static String get form_validation_max_length =>
      values['form_validation_max_length'] ?? _kDefaultInvalidError;
  static String get form_validation_max_number =>
      values['form_validation_max_number'] ?? _kDefaultInvalidError;
  static String get form_validation_min_length =>
      values['form_validation_min_length'] ?? _kDefaultInvalidError;
  static String get form_validation_min_number =>
      values['form_validation_min_number'] ?? _kDefaultInvalidError;
  static String get form_validation_number =>
      values['form_validation_number'] ?? _kDefaultInvalidError;
  static String get form_validation_number_decimal =>
      values['form_validation_number_decimal'] ?? _kDefaultInvalidError;
  static String get form_validation_phone_number =>
      values['form_validation_phone_number'] ?? _kDefaultInvalidError;
  static String get form_validation_required =>
      values['form_validation_required'] ?? _kDefaultInvalidError;
}
