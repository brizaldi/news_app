import 'package:dartz/dartz.dart';

import 'failures.dart';

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<DateTime>, DateTime> validateDateTime(String input) {
  if (DateTime.tryParse(input) == null) {
    return left(ValueFailure.invalidDateTime(failedValue: DateTime.now()));
  } else {
    return right(DateTime.parse(input));
  }
}
