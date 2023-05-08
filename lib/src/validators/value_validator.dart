import 'package:json_class/json_class.dart';

abstract class ValueValidator extends JsonClass {
  String? validate({
    required String label,
    required String? value,
  });
}
