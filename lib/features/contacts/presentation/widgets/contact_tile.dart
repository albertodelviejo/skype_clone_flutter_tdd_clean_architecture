import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/presentation/bloc/bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/presentation/bloc/contacts_bloc.dart';

class ContactTile extends StatelessWidget {
  final String name;
  final String photo_uri;

  ContactTile({@required this.name, this.photo_uri});

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
