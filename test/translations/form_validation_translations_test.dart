import 'package:flutter_test/flutter_test.dart';
import 'package:form_validation/form_validation.dart';

void main() {
  test('keys match variable', () {
    expect(
      FormValidationTranslations.form_validation_currency.key,
      'form_validation_currency',
    );

    expect(
      FormValidationTranslations.form_validation_currency_positive.key,
      'form_validation_currency_positive',
    );

    expect(
      FormValidationTranslations.form_validation_email.key,
      'form_validation_email',
    );

    expect(
      FormValidationTranslations.form_validation_max_length.key,
      'form_validation_max_length',
    );

    expect(
      FormValidationTranslations.form_validation_max_number.key,
      'form_validation_max_number',
    );

    expect(
      FormValidationTranslations.form_validation_min_length.key,
      'form_validation_min_length',
    );

    expect(
      FormValidationTranslations.form_validation_min_number.key,
      'form_validation_min_number',
    );

    expect(
      FormValidationTranslations.form_validation_number.key,
      'form_validation_number',
    );

    expect(
      FormValidationTranslations.form_validation_number_decimal.key,
      'form_validation_number_decimal',
    );

    expect(
      FormValidationTranslations.form_validation_phone_number.key,
      'form_validation_phone_number',
    );

    expect(
      FormValidationTranslations.form_validation_required.key,
      'form_validation_required',
    );
  });
}
