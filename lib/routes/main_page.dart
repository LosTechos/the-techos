import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pantallas/routes/budget_page.dart';
import 'package:pantallas/routes/payments.dart';
import 'package:pantallas/widgets/drawer.dart';
import 'landing_page.dart';

class MainPage extends StatefulWidget {
  final Response? token;
  final Response? loginInfo;

  MainPage({
    Key? key,
    required this.token,
    required this.loginInfo
  }) : super (key: key);

  @override
  _StateMainPage createState() => _StateMainPage();
}

class _StateMainPage extends State<MainPage>{
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  int _index = 0;
  int get index => _index;
  late Response budget;

  set index(int value) {
    _index = min(value, 2);
    setState(() {});
  }

  void getbudget() async {
    budget = await Dio().get(
      'https://los-techos.herokuapp.com/api/budget',
      options: Options(
        contentType: Headers.jsonContentType,
        headers: { 'access-token': widget.token?.data['token'] }
      )
    );
  }

  @override
  void initState() {
    super.initState();
    getbudget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         Expanded(
           child: IndexedStack(
             index: index,
             children: [
               startPage(),
               Payments(token: widget.token?.data['token']),
               BudgetPage(budget: budget,),
             ],
           ),
         ),
          barraNav()
        ],
      ),
    );
  }

  Widget startPage() {
    var datos = widget.loginInfo?.data;
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
          "Welcome ${datos[0]['uName'] ?? "Joel"}!",
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
      items: [
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
        widget.token?.data['roId'] != 1? BottomNavigationBarItem(
          icon: Icon(MdiIcons.bellOutline),
          label: 'Notifications',
        ) : BottomNavigationBarItem(
          icon: Icon(MdiIcons.tuneVertical),
          label: 'Admin',
        ),
      ],
    );
  }
}