import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../../auth/data/models/user_model.dart';
import '../bloc/search_bloc.dart';

class UserSearchTile extends StatelessWidget {
  final UserModel user;
  const UserSearchTile({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<SearchBloc>(context).add(SearchTilePressedEvent(
            user: UserModel.fromFirebaseUser(sl<FirebaseAuth>().currentUser),
            peer: user));
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(user.photoURL)),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    user.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(user.email,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.white60)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  factory UserSearchTile.fromUserModel(UserModel userModel) {
    return UserSearchTile(
      user: userModel,
    );
  }
}
