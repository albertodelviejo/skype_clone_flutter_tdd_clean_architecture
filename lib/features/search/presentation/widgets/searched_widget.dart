import 'package:flutter/material.dart';
import 'user_search_tile.dart';

class SearchedWidget extends StatelessWidget {
  final List<UserSearchTile> list;
  const SearchedWidget({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return list[index];
              }),
        ]),
      ),
    );
  }
}
