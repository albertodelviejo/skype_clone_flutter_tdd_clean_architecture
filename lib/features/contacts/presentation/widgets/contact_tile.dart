import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  final String name;
  final String photo_uri;

  ContactTile({@required this.name, this.photo_uri});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
          ),
          Text(
            name,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
