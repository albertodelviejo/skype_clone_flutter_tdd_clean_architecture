import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_bloc.dart';
import '../widgets/search_field_widget.dart';
import '../widgets/searched_widget.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          searchFieldWidget(context, searchEditingController),
          BlocListener<SearchBloc, SearchState>(
            listener: (context, state) {
              if (state is SearchTilePressedState) {
                Navigator.of(context).pushNamed('/chat', arguments: [
                  state.user,
                  state.peer,
                ]);
              }
            },
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial || state is SearchTilePressedState) {
                  return Container();
                } else if (state is SearchingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SearchedState) {
                  return SearchedWidget(list: state.listOfTiles);
                } else if (state is SearchError) {
                  return Text('Error');
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
