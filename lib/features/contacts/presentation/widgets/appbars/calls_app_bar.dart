import 'package:flutter/material.dart';

Widget callsAppBar(BuildContext context) {
  return AppBar(
    leading: Icon(Icons.notifications),
    title: Text('Calls'),
    centerTitle: true,
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: Icon(Icons.search),
          onPressed: () => Navigator.of(context).pushNamed('/search'),
        ),
      )
    ],
  );
}
