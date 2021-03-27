import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/appbars/contacts_app_bar.dart';
import '../widgets/contacts_body.dart';

class MainPage extends StatefulWidget {
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedTabIndex = 0;

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showSelectedAppBar(_selectedTabIndex, context),
      body: _showSelectedPage(_selectedTabIndex, context), //buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _changeIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone), label: "Contacts"),
        ],
      ),
    );
  }

  Widget _showSelectedPage(int _selectedPage, BuildContext context) {
    switch (_selectedPage) {
      case 0:
        return Center(child: Text("Chats"));

      case 1:
        return Center(child: Text("Calls"));

      case 2:
        return contactsBody(context);
      default:
        return Text('');
    }
  }

  Widget _showSelectedAppBar(int _selectedPage, BuildContext context) {
    switch (_selectedTabIndex) {
      case 0:
        return AppBar(
          actions: [Icon(Icons.notifications)],
        );
      case 1:
        return AppBar();
      case 2:
        return contactsAppBar(context);
      default:
        return AppBar();
    }
  }
}
