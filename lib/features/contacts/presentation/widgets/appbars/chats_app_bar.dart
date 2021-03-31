import 'package:flutter/material.dart';

Widget chatsAppBar() {
  return AppBar(
    leading: Icon(Icons.notifications),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.search),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.more_vert_outlined),
      )
    ],
  );
}
