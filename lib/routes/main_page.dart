import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pantallas/routes/lista_casa.dart';
import 'package:pantallas/routes/login.dart';

class MainPage extends StatefulWidget {
  _StateMainPage createState() => _StateMainPage();
}

class _StateMainPage extends State<MainPage>{
  static CenterOnLocationUpdate _centerOnLocationUpdate;
  static StreamController<double> _centerCurrentLocationStreamController;
  MapController controller;
  String horaAp = "00:00";
  String horaCi = "00:00";
  final scontroller = FloatingSearchBarController();
  int _index = 0;
  int get index => _index;

  set index(int value) {
    _index = min(value, 1);
    _index == 1 ? scontroller.hide() : scontroller.show();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _centerOnLocationUpdate = CenterOnLocationUpdate.first;
    _centerCurrentLocationStreamController = StreamController<double>();
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
              leading: Icon(MdiIcons.onepassword),
              title: Text("Cambiar contraseña"),
              onTap: () {
              },
            ),
           ListTile(
              leading: Icon(MdiIcons.faceProfile),
              title: Text("Cambiar foto de perfil"),
              onTap: () {},
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
                  mapa(),
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
          label: 'My House',
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.walletOutline),
          label: 'Payments',
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.bookmarkOutline),
          label: 'Reminders',
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.bellOutline),
          label: 'Notifications',
        ),
      ],
    );
  }

  Widget horarios(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 8
      ),
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("Lunes", style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5.0
                                  ),
                                  Center(
                                    child: Text("Abre",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Text(horaAp,
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaAp = "${date.hour}:${date.minute <= 9
                                          ? '0'+ date.minute.toString()
                                          : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5.0
                                    ),
                                    Center(
                                      child: Text("Cierra",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                    Text(horaCi,
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaCi = "${date.hour}:${date.minute <= 9
                                        ? '0'+ date.minute.toString()
                                        : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
                ]
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text("Martes",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 5.0
                                  ),
                                  Center(
                                    child: Text("Abre",
                                      style: TextStyle(
                                          fontSize: 20,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Text(horaAp,
                                    style: TextStyle(
                                        fontSize: 40,
                                       color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaAp = "${date.hour}:${date.minute <= 9
                                        ? '0'+ date.minute.toString()
                                        : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: 5.0
                                    ),
                                    Center(
                                      child: Text("Cierra",
                                        style: TextStyle(
                                            fontSize: 20,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                    Text(horaCi,
                                      style: TextStyle(
                                          fontSize: 40,
                                        color: Colors.white
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaCi = "${date.hour}:${date.minute <= 9
                                        ? '0'+ date.minute.toString()
                                        : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text("Miercoles",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 5.0
                                  ),
                                  Center(
                                    child: Text("Abre",
                                      style: TextStyle(
                                          fontSize: 20,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Text(horaAp,
                                    style: TextStyle(
                                        fontSize: 40,
                                      color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaAp = "${date.hour}:${date.minute <= 9
                                        ? '0'+ date.minute.toString()
                                        : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: 5.0
                                    ),
                                    Center(
                                      child: Text("Cierra",
                                        style: TextStyle(
                                            fontSize: 20,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                    Text(horaCi,
                                      style: TextStyle(
                                          fontSize: 40,
                                        color: Colors.white
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaCi = "${date.hour}:${date.minute <= 9
                                        ? '0'+ date.minute.toString()
                                        : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text("Jueves",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 5.0
                                  ),
                                  Center(
                                    child: Text("Abre",
                                      style: TextStyle(
                                          fontSize: 20,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Text(horaAp,
                                    style: TextStyle(
                                        fontSize: 40,
                                      color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaAp = "${date.hour}:${date.minute <= 9
                                        ? '0'+ date.minute.toString()
                                        : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5.0
                                    ),
                                    Center(
                                      child: Text("Cierra",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                    Text(horaCi,
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaCi = "${date.hour}:${date.minute <= 9
                                        ? '0'+ date.minute.toString()
                                        : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text("Viernes",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5.0
                                  ),
                                  Center(
                                    child: Text("Abre",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Text(horaAp,
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaAp = "${date.hour}:${date.minute <= 9
                                        ? '0'+ date.minute.toString()
                                        : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: 5.0
                                    ),
                                    Center(
                                      child: Text("Cierra",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                    Text(horaCi,
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaCi = "${date.hour}:${date.minute <= 9
                                        ? '0'+ date.minute.toString()
                                        : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text("Sábado",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5.0
                                  ),
                                  Center(
                                    child: Text("Abre",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(horaAp,
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaAp = "${date.hour}:${date.minute <= 9
                                        ? '0'+ date.minute.toString()
                                        : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: 5.0
                                    ),
                                    Center(
                                      child: Text("Cierra",
                                        style: TextStyle(
                                            fontSize: 20,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                    Text(horaCi,
                                      style: TextStyle(
                                          fontSize: 40,
                                        color: Colors.white
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaCi = "${date.hour}:${date.minute <= 9
                                        ? '0'+ date.minute.toString()
                                        : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text("Domingo",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 5.0
                                  ),
                                  Center(
                                    child: Text("Abre",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(horaAp,
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaAp = "${date.hour}:${date.minute <= 9
                                        ? '0'+ date.minute.toString()
                                        : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 500,
                          child: Card(
                            color: Color.fromRGBO(37, 40, 80, 1.0),
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(40),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: 5.0
                                    ),
                                    Center(
                                      child: Text("Cierra",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                    Text(horaCi,
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                DatePicker.showTime12hPicker(context,
                                  onChanged: (date) {
                                    print(date);
                                    setState((){
                                      horaCi = "${date.hour}:${date.minute <= 9
                                        ? '0'+ date.minute.toString()
                                        : date.minute.toString() }";
                                    });
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ],
              )

            ],
          ),
        )
      ],
    );
  }

  Widget mapa(){
    return FlutterMap(
      options: MapOptions(
        zoom: 13.0,
        maxZoom: 17,
        minZoom: 11,
        bounds: LatLngBounds(
            LatLng(28.88556450665763,-105.87319044637228),
            LatLng(28.44997758291972, -106.2980521196089)
        ),
        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        plugins: <MapPlugin>[
          LocationPlugin(),
        ],
      ),
      children: [
        TileLayerWidget(options: TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
          retinaMode: true && MediaQuery.of(context).devicePixelRatio > 2.0,
        )),
        MarkerLayerWidget(
          options: MarkerLayerOptions(
            markers: [
              Marker(
                point: LatLng(28.664663181910544, -106.09851822790183),
                builder: (BuildContext context) {
                  return Icon(Icons.house_rounded);
                },
              ),
              Marker(
                point: LatLng(28.647858432311345, -106.12152350755025),
                builder: (BuildContext context) {
                  return Icon(Icons.house_rounded);
                },
              ),
              Marker(
                point: LatLng(28.652162390265705, -106.084615965879),
                builder: (BuildContext context) {
                  return Icon(Icons.house_rounded);
                },
              ),
              Marker(
                point: LatLng(28.631984031988527, -106.09809530941025),
                builder: (BuildContext context) {
                  return Icon(Icons.house_rounded);
                },
              ),

              Marker(
                point: LatLng(28.671969459329173, -106.10199770354095),
                builder: (BuildContext context) {
                  return Icon(Icons.house_rounded);
                },
              ),
              Marker(
                point: LatLng(28.653404654848185, -106.10972105113736),
                builder: (BuildContext context) {
                  return Icon(Icons.house_rounded);
                },
              ),
              Marker(
                point: LatLng(28.694874585342188, -106.11683296737004),
                builder: (BuildContext context) {
                  return Icon(Icons.house_rounded);
                },
              ),
              Marker(
                point: LatLng(28.615889645421237, -106.07508038720991),
                builder: (BuildContext context) {
                  return Icon(Icons.house_rounded);
                },
              ),

            ]
          ),

        ),
        LocationMarkerLayerWidget(plugin: LocationMarkerPlugin(
          centerCurrentLocationStream: _centerCurrentLocationStreamController.stream,
          centerOnLocationUpdate: _centerOnLocationUpdate,
        )),
        Positioned(
          right: 20.0,
          bottom: 20.0,
          child: FloatingActionButton(
            heroTag: 'gps_fixed',
            child: Icon(
              Icons.gps_fixed,
              color: Colors.blue,
            ),
            onPressed: () {
              setState(() => _centerOnLocationUpdate = CenterOnLocationUpdate.first);
              _centerCurrentLocationStreamController.add(18);
            },
            backgroundColor: Colors.white,
          ),
        ),
      ],
      layers: [
      ],
      mapController: controller,
    );
  }

}