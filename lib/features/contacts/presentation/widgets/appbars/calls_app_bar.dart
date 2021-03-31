import 'package:flutter/material.dart';

Widget callsAppBar() {
  return AppBar(
    leading: Icon(Icons.notifications),
    title: Text('Calls'),
    centerTitle: true,
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.search),
      )
    ],
  );
}
