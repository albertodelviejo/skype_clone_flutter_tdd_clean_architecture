import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Center(
          child: Container(
              child: Column(
        children: [
          Text("Cargando sus contactos"),
          SizedBox(
            height: 10,
          ),
          CircularProgressIndicator(),
        ],
      ))),
    );
  }
}
