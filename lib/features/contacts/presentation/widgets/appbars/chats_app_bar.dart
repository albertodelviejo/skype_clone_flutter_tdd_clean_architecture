import 'package:flutter/material.dart';

Widget chatsAppBar(BuildContext context) {
  return AppBar(
    leading: Icon(Icons.notifications),
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
        child: Icon(Icons.more_vert_outlined),
      )
    ],
  );
}
