import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pantallas/widgets/drawer.dart';

class Payments extends StatefulWidget {
  final Response? loginInfo;

  const Payments({
    Key? key,
    required this.loginInfo
  }) : super(key: key);

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
  BuildContext? originalBuild;
  Response? deuda;
  late BuildContext contextoDialogo;
  final _picker = ImagePicker();

  void getDebts() async {
    var res = await Dio().get(
      'https://los-techos.herokuapp.com/api/debt/${widget.loginInfo?.data['id'] ?? 71}',
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {
          'access-token': widget.loginInfo?.data['token']
        }
      )
    );
    setState(() {
      deuda = res;
    });
  }

  @override
  void initState() {
    super.initState();
    getDebts();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> withDebts = [
      SizedBox(
        width: double.infinity,
        height: 10,
      ),
      SizedBox(
        height: 230,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Colors.red,
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
                    color: Colors.white
                ),
                SizedBox(
                    height: 5.0
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 80,
                  child: Text('You have pending payments',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        height: 3,
                        color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.3,
                  text: TextSpan(
                    text: "Your current debt is: ${deuda?.data[0]['hDebt']} \n"
                        "and must be paid before: ${DateFormat('MMM-dd-yyyy').format(DateTime.now())}"
                  )
                )
              ],
            ),
            onTap: () {},
          ),
        ),
      ),
    ];
    List<Widget> withoutDebts = [
      SizedBox(
        width: double.infinity,
        height: 10,
      ),
      Container(
        height: 180,
        child: Card(
          color: Colors.green,
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
                  color: Colors.white,
                ),
                SizedBox(
                    height: 5.0
                ),
                Container(
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
              ],
            ),
            onTap: () {},
          ),
        ),
      ),
    ];
    originalBuild = context;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.cash),
        onPressed: () async {
          XFile? imagen = await _picker.pickImage(
            source: ImageSource.gallery,
          );
          Uint8List? list = await imagen?.readAsBytes();
          var encImg = base64Encode(list ?? []);
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (dialogContext) {
              contextoDialogo = dialogContext;
              return AlertDialog(
                title: Text("Please wait...", textAlign: TextAlign.center,),
                actions: [],
                content: CircularProgressIndicator(color: Colors.green,),
              );
            },
          );
          Response res = await Dio().put(
            'https://los-techos.herokuapp.com/api/upload',
            options: Options(
                contentType: Headers.jsonContentType,
                headers: { 'access-token' : widget.loginInfo!.data['token'] }
            ),
            data: {
              'uId': 71,
              'pImage': encImg,
            },
          ).whenComplete(() {
            Navigator.pop(contextoDialogo);
            ScaffoldMessenger.of(originalBuild?? context).showSnackBar(SnackBar(
              content: Text("Ticket sent"),
              backgroundColor: Colors.green,
            ));
          });
        },
      ),
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
              children: deuda?.data[0]['hDebt'] == null?  withoutDebts : withDebts,
            ),
          )
        ]
      ),
    );
  }
}
