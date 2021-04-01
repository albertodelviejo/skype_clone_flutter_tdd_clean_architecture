part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchingState extends SearchState {}

class SearchedState extends SearchState {
  final List<UserSearchTile> listOfTiles;

  SearchedState({@required this.listOfTiles});
}

class SearchError extends SearchState {}

class SearchTilePressedState extends SearchState {}
