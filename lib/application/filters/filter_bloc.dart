import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/filters/value_objects.dart';
import '../../extra/utils/logging.dart';

part 'filter_bloc.freezed.dart';
part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterState.initial());

  @override
  void onTransition(
    Transition<FilterEvent, FilterState> transition,
  ) {
    Log.info(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onEvent(FilterEvent event) {
    Log.info(event.toString());
    super.onEvent(event);
  }

  @override
  Stream<FilterState> mapEventToState(
    FilterEvent event,
  ) async* {
    yield* event.map(
      categoryChanged: (e) async* {
        yield state.copyWith(
          category: e.category,
        );
      },
      keywordChanged: (e) async* {
        yield state.copyWith(
          keyword: e.keyword,
        );
      },
    );
  }
}
