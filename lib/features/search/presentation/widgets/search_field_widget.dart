import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_bloc.dart';

Widget searchFieldWidget(
    BuildContext context, TextEditingController searchEditingController) {
  return Container(
    height: 60,
    color: Colors.blue[600],
    child: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: searchEditingController,
            cursorColor: Colors.black,
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  onPressed: () => searchEditingController.clear(),
                ),
                border: InputBorder.none),
            onChanged: (value) {
              BlocProvider.of<SearchBloc>(context)
                  .add(SearchStringEvent(searchField: value));
            },
          )),
    ),
  );
}
