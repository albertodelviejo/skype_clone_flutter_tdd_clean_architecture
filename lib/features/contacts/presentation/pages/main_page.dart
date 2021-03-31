import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/presentation/bloc/bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/presentation/widgets/appbars/calls_app_bar.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/presentation/widgets/appbars/chats_app_bar.dart';
import '../../../../injection_container.dart';
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
    return BlocProvider(
      create: (_) => sl<ContactsBloc>(),
      child: Scaffold(
        appBar: _showSelectedAppBar(_selectedTabIndex, context),
        body: _showSelectedPage(_selectedTabIndex, context),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          onTap: _changeIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
            BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
            BottomNavigationBarItem(
                icon: Icon(Icons.contact_phone), label: "Contacts"),
          ],
          selectedItemColor: Colors.blue,
        ),
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
        return chatsAppBar();
      case 1:
        return callsAppBar();
      case 2:
        return contactsAppBar();
      default:
        return AppBar();
    }
  }
}
