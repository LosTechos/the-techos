import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pantallas/widgets/drawer.dart';

class AdminPage extends StatefulWidget {
  _StateAdminPage createState() => _StateAdminPage();
}

class _StateAdminPage extends State<AdminPage> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      endDrawer: DrawerApp(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(MdiIcons.plus, color: Colors.black,),
            onPressed: () {

            },
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Administration page",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.normal
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                    child: ListTile(
                      isThreeLine: false,
                      leading: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: Icon(MdiIcons.alert, color: Colors.black,size: 30,),
                      ),
                      title: Text("There have been expenses in the budget"),
                    )
                ),
                Card(
                    child: ListTile(
                      isThreeLine: false,
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(MdiIcons.alert, color: Colors.black,size: 30,),
                      ),
                      title: Text("You have pending payments"),
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}