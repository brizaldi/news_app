import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import '../core/value_objects.dart';
import '../core/value_validators.dart';

class Category extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Category(String input) {
    return Category._(
      validateStringNotEmpty(input),
    );
  }

  const Category._(this.value);

  factory Category.empty() => Category('');
}
