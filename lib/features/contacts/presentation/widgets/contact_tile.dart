import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  final String name;

  ContactTile({@required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  name,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Invite'),
                ),
              ),
            ],
          ),
        ),
        onTap: () {} //=> dispatchPressedEvent(context),
        );
  }
}
