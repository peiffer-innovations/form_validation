# form_validation

Form validators that can be used directly via code or constructed from JSON to provide more dynamic validation.

[Live Web Example](https://peiffer-innovations.github.io/form_validation/web/index.html)

## Using the library

Add the repo to your Flutter `pubspec.yaml` file.

```
dependencies:
  form_validation: <<version>> 
```

Then run...
```
flutter packages get
```


## Validators

The library provides a set of built-in validators while also providing a mechanism for applications to provide their own validators.  All the built-in validators are able to be deserialized via JSON.  They all expect an attribute of `type` to match a specific value when being desearialized.

**Note**: With the sole exception of `RequiredValidator`, all built in validators will pass on `null` or empty values.

Class                  | Type           | Description
-----------------------|----------------|------------
`CurrencyValidator`    | `currency`     | Ensures the value is a valid currency
`EmailValidator`       | `email`        | Ensures the value is a validly formatted email address
`MaxLengthValidator`   | `max_length`   | Ensures the value contains no more than a set number of characters
`MaxNumberValidator`   | `max_number`   | Ensures the value is no larger than a given number
`MinLengthValidator`   | `min_length`   | Ensures the value contains no fewer than a set number of characters
`MinNumberValidator`   | `min_number`   | Ensures the value is no smaller than a given number
`NumberValidator`      | `number`       | Ensures the value is a valid number
`PhoneNumberValidator` | `phone_number` | Ensures the value is a validly formatted phone number
`RequiredValidator`    | `required`     | Ensures the value is not `null`, empty, nor white space only


## Validation Messages / Translations

The library provides a default set of English error messages for each validator's error message.  This library uses the [static_translations](https://pub.dev/packages/static_translations) library for the string and language management, see it for details on how to override the defaults or provide values for other languages.

Key                                 | Parameters        | Description
------------------------------------|-------------------|------------
`form_validation_currency`          | `label`           | Used when an invalid currency value is detected
`form_validation_currency_positive` | `label`           | Used when a valid, but negative, currency value is detected
`form_validation_email`             | `label`           | Used when an invalid email is detected
`form_validation_max_length`        | `label`, `length` | Used when a value contains more characters than `length`
`form_validation_max_number`        | `label`, `number` | Used when a value is larger than `number`
`form_validation_min_length`        | `label`, `length` | Used when a value contains fewer characters than `length`
`form_validation_min_number`        | `label`, `number` | Used when a value is smaller than `number`
`form_validation_number`            | `label`           | Used when a number is expected but not detected
`form_validation_number_decimal`    | `label`           | Used when a number is detected, but not allowed to be a decimal
`form_validation_phone_number`      | `label`           | Used when an invalid phone number is detected
`form_validation_required`          | `label`           | Used when a value is required, but detected as `null`, empty, or all white space


## JSON Support

The `Validator` class can be used to decode a list of child `ValueValidator` entries.  Each of the built-in validators can be deserialized via JSON.  In addition to being able to deserialize from JSON, each of the built-in validators supports serializing to a JSON compatible map via `toJson` or an actual JSON encoded string via `toJsonString`.

The overall struction needs to be:

```json
{
  "validators": [
    // One or more of the JSON objects shown below
  ]
}
```

### CurrencyValidator

```json
{
  "allowNegative": <bool>, // Default: true; states whether negative values are allowed or not
  "type": "currency"
}
```


### EmailValidator

```json
{
  "type": "email"
}
```


### MaxLengthValidator

```json
{
  "length": <int>, // The maximum length the value may be
  "type": "max_length"
}
```


### MaxNumberValidator

```json
{
  "length": <int>, // The maximum number the value may be
  "type": "max_number"
}
```


### MinLengthValidator

```json
{
  "length": <int>, // The minimum length the value may be
  "type": "min_length"
}
```


### MinNumberValidator

```json
{
  "length": <int>, // The minimum number the value may be
  "type": "min_number"
}
```


### NumberValidator

```json
{
  "type": "number"
}
```


### PhoneNumberValidator

```json
{
  "type": "phone_number"
}
```


### RequiredValidator

```json
{
  "type": "required"
}
```


## Custom Validators

The `Validator` supports custom validators being added either directly through classes extending the `ValueValidator` abstract class and passing them in via the constructor.  Alternatively, an application may register a validator type with `Validator` using the `registerCustomValidatorBuilder` function.

### Example

```dart
class MyCustomValidator extends ValueValidator {
  static const type = 'my_custom_validator';

  static MyCustomValidator fromDynamic(dynamic map) {
    MyCustomValidator({
      // initialization args go here
    });

    MyCustomValidator result;

    if (map != null) {
      assert(map['type'] == type);

      result = MyCustomValidator(
        // Do additional JSON conversion here
      )
    })

    return result;
  }

  Map<String, dynamic> toJson() => {
    // add additional attributes here
    "type": type,
  }

  String validate({
    @required BuildContext context,
    @required String label,
    @required String value,
  }) {
    String error;

    // In general, validators should pass if the value is empty.  Combine 
    // validators with the RequiredValidator to ensure a value is non-empty.
    if (value?.isNotEmpty == true) {
      // Do processing to determine if the value is valid or not
    }

    return error;
  }
}

...

void main() {
  Validator.registerCustomValidatorBuilder(
    MyCustomValidator.type,
    MyCustomValidator.fromDynamic,
  );

  // start app
} 

...

var jsonStr = '''
{
  "validators": [{
    "type": "required"
  }, {
    "type": "my_custom_validator"
  }]
}
'''

// This will create a validation chain with the RequiredValidator as well as the
// MyCustomValidator defined above
var validator = Validator.fromDynamic(json.decode(jsonStr));
```
