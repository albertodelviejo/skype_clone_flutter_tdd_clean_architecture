import 'package:flutter/material.dart';

Widget contactsAppBar(BuildContext context) {
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: Icon(Icons.search),
          onPressed: () => Navigator.of(context).pushNamed('/search'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.more_vert),
      )
    ],
    centerTitle: true,
    title: Text("Contacts"),
    leading: Icon(Icons.notifications),
  );
}
