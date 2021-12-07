import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pantallas/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPage extends StatefulWidget {
  _StateAdminPage createState() => _StateAdminPage();
}

class _StateAdminPage extends State<AdminPage> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final GlobalKey<FormFieldState> formKey = GlobalKey<FormFieldState>();
  late Future<List<Map<String, dynamic>>> _datosNotas;
  String? infoNota;
  String? datosGuardar;
  bool card1 = false;
  bool card2 = false;


  Future<void> _guardarNotas(String nuevaNota) async {
    final SharedPreferences prefs = await _prefs;
    final List<String> list = (prefs.getStringList("notas") ?? []);

    if (nuevaNota.isEmpty || nuevaNota == "") {
      setState(() {
        _datosNotas = prefs.setStringList("notas", list).then((value) {
          var jsonData = json.decode(list.toString());
          return jsonData;
        });
      });
    } else {
      list.add(nuevaNota);
      setState(() {
        _datosNotas = prefs.setStringList("notas", list).then((value) {
          var jsonData = json.decode(list.toString());
          return jsonData;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();

  }

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
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: Text("Write the message"),
                    content: SizedBox(
                      height: 180,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 100,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    icon: Icon(MdiIcons.alert)
                                ),
                                items: [
                                  DropdownMenuItem(
                                    child: Text("High priority"),
                                    value: {"icon": MdiIcons.alert, "color": Colors.red},
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Reminder"),
                                    value: {"icon": MdiIcons.alert, "color": Colors.yellow},
                                  ),
                                ],
                                onChanged: (value){
                                  setState(() {
                                    infoNota = value.toString();
                                  });
                                },
                                validator: (value){
                                  if (value == null || value == 0){
                                    return 'Select a priority';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            TextFormField(
                                decoration: InputDecoration(
                                    icon: Icon(MdiIcons.message),
                                    hintText: "Write a message"
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please write message';
                                  }
                                  return null;
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text("Close"),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Save"),
                        onPressed: () {
                          formKey.currentState?.validate();
                          if (card1 == false && card2 == false) {
                            setState(() {
                              card1 = true;
                            });
                          } else if (card1 == true && card2 == false) {
                            setState(() {
                              card2 = true;
                            });
                          }
                          Navigator.of(dialogContext).pop();
                        },
                      ),
                    ],
                  );
                }
              );
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
      body:ListView(
        shrinkWrap: true,
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                card1 == false? SizedBox(width: 1, height: 1,) :Card(
                    child: ListTile(
                      isThreeLine: false,
                      leading: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: Icon(MdiIcons.alert, color: Colors.black,size: 30,),
                      ),
                      title: Text("Expenses has been updated"),
                    )
                ),
                card2 == false? SizedBox(width: 1, height: 1,) : Card(
                    child: ListTile(
                      isThreeLine: false,
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(MdiIcons.alert, color: Colors.black,size: 30,),
                      ),
                      title: Text("Expenses has been updated"),
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

/*

 */