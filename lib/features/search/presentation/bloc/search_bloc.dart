import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/search/domain/usecases/search.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/search/presentation/widgets/user_search_tile.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Search search;
  SearchBloc({@required this.search}) : super(SearchInitial());
  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchStringEvent) {
      yield SearchingState();
      final eitherFailureQuery =
          await search(SearchParams(searchField: event.searchField));

      yield* eitherFailureQuery.fold((l) async* {
        yield SearchError();
      }, (r) async* {
        List<UserSearchTile> listOfUsersSearched = [];

        r.forEach((element) {
          listOfUsersSearched.add(UserSearchTile.fromUserModel(element));
        });

        yield SearchedState(listOfTiles: listOfUsersSearched);
      });
    } else if (event is SearchTilePressedEvent) {
      yield SearchTilePressedState();
    }
  }
}
