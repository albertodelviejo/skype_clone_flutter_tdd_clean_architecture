part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchStringEvent extends SearchEvent {
  final String searchField;

  SearchStringEvent({@required this.searchField});
}

class SearchTilePressedEvent extends SearchEvent {
  final UserModel user;
  final UserModel peer;

  SearchTilePressedEvent({@required this.user, @required this.peer});
}
