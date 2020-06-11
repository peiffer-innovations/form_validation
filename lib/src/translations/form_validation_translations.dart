import 'package:meta/meta.dart';
import 'package:static_translations/static_translations.dart';

/// Provides the default (English) translations used by the library.
@immutable
class FormValidationTranslations {
  FormValidationTranslations._();

  static const _kDefaultInvalidError = '{label} is invalid';

  static const form_validation_currency = TranslationEntry(
    key: 'form_validation_currency',
    value: _kDefaultInvalidError,
  );

  static const form_validation_currency_positive = TranslationEntry(
    key: 'form_validation_currency_positive',
    value: _kDefaultInvalidError,
  );

  static const form_validation_email = TranslationEntry(
    key: 'form_validation_email',
    value: _kDefaultInvalidError,
  );

  static const form_validation_max_length = TranslationEntry(
    key: 'form_validation_max_length',
    value: '{label} must contain at most {length} characters',
  );

  static const form_validation_max_number = TranslationEntry(
    key: 'form_validation_max_number',
    value: '{label} must be at most {number}',
  );

  static const form_validation_min_length = TranslationEntry(
    key: 'form_validation_min_length',
    value: '{label} must contain at least {length} characters',
  );

  static const form_validation_min_number = TranslationEntry(
    key: 'form_validation_min_number',
    value: '{label} must be at least {number}',
  );

  static const form_validation_number = TranslationEntry(
    key: 'form_validation_number',
    value: _kDefaultInvalidError,
  );

  static const form_validation_number_decimal = TranslationEntry(
    key: 'form_validation_number_decimal',
    value: _kDefaultInvalidError,
  );

  static const form_validation_phone_number = TranslationEntry(
    key: 'form_validation_phone_number',
    value: _kDefaultInvalidError,
  );

  static const form_validation_required = TranslationEntry(
    key: 'form_validation_required',
    value: '{label} is required',
  );
}
