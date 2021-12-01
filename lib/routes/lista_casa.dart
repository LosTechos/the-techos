import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pantallas/widgets/drawer.dart';

Widget budget(BuildContext context) {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  return Scaffold(
    key: scaffoldState,
    appBar: AppBar(
      actions: [
        IconButton(
          icon: Icon(MdiIcons.menu, color: Colors.black,),
          onPressed: () {
            scaffoldState.currentState.openEndDrawer();
          },
        )
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text(
        "Budget",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.normal
        ),
      ),
    ),
    endDrawer: DrawerApp(),
    body: ListView(
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
    ),
  );
}
