import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

class ContactsInitial extends ContactsState {}

class LoadingContacts extends ContactsState {}

class LoadedContacts extends ContactsState {
  final Iterable contacts;

  LoadedContacts({@required this.contacts});
}

class ErrorContacts extends ContactsState {
  final String message;

  ErrorContacts({@required this.message});
}

class NavigateToChatContacts extends ContactsState {}
