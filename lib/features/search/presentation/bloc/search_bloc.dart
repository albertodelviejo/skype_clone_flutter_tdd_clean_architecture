import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/search/domain/usecases/search.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Search usecase;
  SearchBloc({@required this.usecase}) : super(SearchInitial());
  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchStringEvent) {
      yield SearchingState();
      final eitherFailureQuery =
          await usecase(SearchParams(searchField: event.searchField));

      yield* eitherFailureQuery.fold((l) async* {
        yield SearchError();
      }, (r) async* {
        yield SearchedState();
      });
    }
  }
}
