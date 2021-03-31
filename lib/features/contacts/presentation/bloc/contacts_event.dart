import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class GetContactsEvent extends ContactsEvent {}

class ContactTilePressedEvent extends ContactsEvent {
  final User user;
  final User peer;

  ContactTilePressedEvent({@required this.user, @required this.peer});
}
