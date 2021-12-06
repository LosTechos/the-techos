import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pantallas/routes/admin_page.dart';
import 'package:pantallas/routes/budget_page.dart';
import 'package:pantallas/routes/payments.dart';
import 'package:pantallas/widgets/drawer.dart';
import 'landing_page.dart';

class MainPage extends StatefulWidget {
  final Response? loginInfo;
  final Response? userInfo;

  MainPage({
    Key? key,
    required this.loginInfo,
    required this.userInfo
  }) : super (key: key);

  @override
  _StateMainPage createState() => _StateMainPage();
}

class _StateMainPage extends State<MainPage>{
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  int _index = 0;
  int get index => _index;
  List<BottomNavigationBarItem> userPage = [
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.homeOutline),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.homeCityOutline),
      label: 'Payments',
    ),
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.walletOutline),
      label: 'Budget',
    ),
  ];
  List<BottomNavigationBarItem> adminPage = [
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.homeOutline),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.walletOutline),
      label: 'Budget',
    ),
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.tuneVertical),
      label: 'Admin',
    )
  ];

  set index(int value) {
    _index = min(value, 2);
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> userElements = [
      startPage(),
      Payments(loginInfo: widget.loginInfo),
      BudgetPage(loginInfo: widget.loginInfo,)
    ];
    List<Widget> adminElements = [
      startPage(),
      BudgetPage(loginInfo: widget.loginInfo),
      AdminPage()
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: index,
              children: widget.loginInfo?.data['roId'] == 1? adminElements : userElements,
            ),
          ),
          barraNav()
        ],
      ),
    );
  }

  Widget startPage() {
    return Scaffold(
      key: scaffoldState,
      endDrawer: DrawerApp(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(MdiIcons.menu, color: Colors.black,),
            onPressed: () {
              scaffoldState.currentState?.openEndDrawer();
            },
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Welcome home ${widget.userInfo?.data[0]['uName'] ?? "User"}!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.normal
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                LandingPage(),
              ],
            ),
          ),
        ],
      ),
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
      items: widget.loginInfo?.data['roId'] == 1? adminPage : userPage,
    );
  }
}