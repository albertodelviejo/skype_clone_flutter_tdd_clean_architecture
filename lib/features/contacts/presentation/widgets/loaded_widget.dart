import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import 'contact_tile.dart';

class LoadedWidget extends StatelessWidget {
  final Iterable contacts;
  const LoadedWidget({Key key, this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ContactTile> contactsTiles = buildListContactTile(contacts);
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(children: <Widget>[
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: contactsTiles.length,
              itemBuilder: (BuildContext context, int index) {
                return contactsTiles[index];
              }),
        ),
      ]),
    );
  }
}

List<ContactTile> buildListContactTile(Iterable<Contact> contacts) {
  List<ContactTile> list = [];
  contacts.forEach((element) {
    list.add(new ContactTile(name: element.displayName));
  });
  return list;
}
