import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domain/usecases/search.dart';
import '../widgets/user_search_tile.dart';
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
      yield SearchTilePressedState(user: event.user, peer: event.peer);
    }
  }
}
