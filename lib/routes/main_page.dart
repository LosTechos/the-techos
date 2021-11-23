import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pantallas/routes/lista_casa.dart';
import 'package:pantallas/routes/login.dart';
import 'package:pantallas/routes/payments.dart';

import 'LandingPage.dart';

class MainPage extends StatefulWidget {
  _StateMainPage createState() => _StateMainPage();
}

class _StateMainPage extends State<MainPage>{
  MapController controller;
  String horaAp = "00:00";
  String horaCi = "00:00";
  final scontroller = FloatingSearchBarController();
  int _index = 0;
  int get index => _index;

  set index(int value) {
    _index = min(value, 2);
    _index == 1 ? scontroller.hide() : scontroller.show();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/Shampoo-Shop.png'),
                    ),
                    SizedBox(
                      width: 15
                    ),
                    Text("Usuario de prueba",
                        style: TextStyle(color: Colors.white),
                    )
                  ]
              ),
            ),
           ListTile(
              leading: Icon(Icons.exit_to_app_outlined),
              title: Text("Cerrar sesión"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginBarber())
                );
              },
            ),

          ],
        ),
      ),
      body: Stack(
        children: [
          barraBusqueda(),
        ],
      ),
    );
  }

  Widget barraBusqueda(){
    return FloatingSearchBar(
      hint: "Search",
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        automaticallyImplyBackButton: true,
        physics: const BouncingScrollPhysics(),
        axisAlignment: 0.0,
        openAxisAlignment: 0.0,
        width: 600,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (query) {  },
        body: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: index,
                children: [
                  LandingPage(),
                  Payments(),
                  listaCasa(context),
                ],
              ),
            ),
            barraNav()
          ],
        ),
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircleAvatar(
              radius: 17,
              child: Text("T"),
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
      builder: (context, builder){
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                List.generate(25, (index){
                  return ListTile(
                    leading: Text(index.toString()),
                  );
                }),
            ),
          ),
        );
      }
    );
  }

  Widget barraNav(){
    return BottomNavigationBar(
      onTap: (value) => index = value,
      currentIndex: index,
      elevation: 18,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      selectedFontSize: 11.5,
      unselectedFontSize: 11.5,
      unselectedItemColor: const Color(0xFF4d4d4d),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.mapOutline),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.homeCityOutline),
          label: 'Payments',
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.walletOutline),
          label: 'Budget',
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.bellOutline),
          label: 'Notifications',
        ),
      ],
    );
  }
}