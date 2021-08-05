import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_status.freezed.dart';

@freezed
class FetchStatus with _$FetchStatus {
  const factory FetchStatus.initial() = Initial;
  const factory FetchStatus.inProgress() = InProgress;
  const factory FetchStatus.success() = Success;
  const factory FetchStatus.failure() = Failure;
}
