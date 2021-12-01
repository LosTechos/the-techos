import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pantallas/widgets/drawer.dart';

class Payments extends StatefulWidget {
  const Payments({Key key}) : super(key: key);

  _StatePayments createState() => _StatePayments();
}

class _StatePayments extends State<Payments> {
  bool noDebt = false;
  double cardHeight = 200;
  Color backgroundColor = Colors.green;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  Color buttonColor = Colors.green;
  Color iconColor = Colors.white;
  IconData warning = Icons.warning_rounded;
  IconData done = Icons.check_circle_sharp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      endDrawer: DrawerApp(),
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
          "Pending payments",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.normal
          ),
        ),
      ),
      body: ListView(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 10,
                ),
                SizedBox(
                  height: 180,
                  width: MediaQuery.of(context).size.width - 25,
                  child: Card(
                    color: backgroundColor,
                    child: InkWell(
                      splashColor: Colors.grey.withAlpha(40),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Icon(
                            Icons.access_time_outlined,
                            size: 50,
                            color: iconColor
                          ),
                          SizedBox(
                            height: 5.0
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 60,
                            child: Text('You have no pending payments',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                height: 3,
                                color: Colors.white
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: noDebt? 0 : 30,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          )
        ]
      ),
    );
  }
}
