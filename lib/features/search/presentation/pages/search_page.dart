import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/search/presentation/bloc/search_bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/search/presentation/widgets/search_field_widget.dart';

import '../../../../injection_container.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchBloc>(),
      child: Scaffold(
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
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return Container();
                } else if (state is SearchingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SearchedState) {
                  return ListView.builder(itemBuilder: null);
                } else if (state is SearchError) {
                  return Text('Error');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
