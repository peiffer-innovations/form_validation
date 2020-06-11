import 'package:flutter/material.dart';
import 'package:json_class/json_class.dart';
import 'package:meta/meta.dart';
import 'package:static_translations/static_translations.dart';

abstract class ValueValidator extends JsonClass {
  String validate({
    @required String label,
    @required Translator translator,
    @required String value,
  });
}
