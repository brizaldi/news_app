import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import '../core/value_objects.dart';
import '../core/value_validators.dart';

class SourceName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory SourceName(String input) {
    return SourceName._(
      validateStringNotEmpty(input),
    );
  }

  const SourceName._(this.value);
}

class Author extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Author(String input) {
    return Author._(
      validateStringNotEmpty(input),
    );
  }

  const Author._(this.value);
}

class Title extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Title(String input) {
    return Title._(
      validateStringNotEmpty(input),
    );
  }

  const Title._(this.value);
}

class Description extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Description(String input) {
    return Description._(
      validateStringNotEmpty(input),
    );
  }

  const Description._(this.value);
}

class NewsUrl extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory NewsUrl(String input) {
    return NewsUrl._(
      validateStringNotEmpty(input),
    );
  }

  const NewsUrl._(this.value);
}

class ImageUrl extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory ImageUrl(String input) {
    return ImageUrl._(
      validateStringNotEmpty(input),
    );
  }

  const ImageUrl._(this.value);
}

class PublishedAt extends ValueObject<DateTime> {
  @override
  final Either<ValueFailure<DateTime>, DateTime> value;

  factory PublishedAt(String input) {
    return PublishedAt._(
      validateDateTime(input),
    );
  }

  const PublishedAt._(this.value);
}

class Content extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Content(String input) {
    return Content._(
      validateStringNotEmpty(input),
    );
  }

  const Content._(this.value);
}
