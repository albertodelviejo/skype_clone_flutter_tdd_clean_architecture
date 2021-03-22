import 'package:flutter/material.dart';

Widget ContactsAppBar(BuildContext context) {
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.search),
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
