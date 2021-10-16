import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget listaCasa(BuildContext context) {
  return ListView(
    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
    children: List.generate(8, (index) {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: ListTile(
          leading: FlutterLogo(),
          title: Text("House $index"),
          subtitle: Text("A MF HOUSE "),
            onTap: () {
              InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {

                },
              );
            },
          isThreeLine: true,
        ),
      );
    }),
  );
}