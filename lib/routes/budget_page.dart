import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pantallas/widgets/drawer.dart';

class BudgetPage extends StatefulWidget {
  final Response? loginInfo;

  const BudgetPage({
    Key? key,
    required this.loginInfo
  });

  @override
  _StateBudgetPage createState() => _StateBudgetPage();
}

class _StateBudgetPage extends State<BudgetPage> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  Response? budget;

  getbudget() async {
    var res = await Dio().get(
        'https://los-techos.herokuapp.com/api/budget',
        options: Options(
            contentType: Headers.jsonContentType,
            headers: { 'access-token': widget.loginInfo?.data['token'] }
        )
    );
    setState(() {
      budget = res;
    });
  }

  @override
  void initState() {
    super.initState();
    getbudget();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(MdiIcons.menu, color: Colors.black,),
              onPressed: () {
                scaffoldState.currentState!.openEndDrawer();
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
        body: SafeArea(
          child: ListView(
            children: [Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(1,18, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 35,
                        height: 190,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 6,
                                  color: Color(0x4B1A1F24),
                                  offset: Offset(0, 2)
                              )
                            ],
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xFF00968A),
                                  Color(0xFFF2A384)
                                ],
                                stops: [0, 1],
                                begin: AlignmentDirectional(0.94, -1),
                                end: AlignmentDirectional(-0.94, 1)
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(129, 0, 20, 18),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Center(
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Current Balance'
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Center(
                              //padding: EdgeInsetsDirectional.fromSTEB(92, 0, 20, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      '\$${budget?.data[0]['budget']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 56,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          //padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                //padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text("History", style: TextStyle(fontSize: 20)),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.92,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                            child: Card(
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              color: Color(0x6639D2C0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(40),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    8, 8, 8, 8),
                                                child: Icon(
                                                  Icons.monetization_on_rounded,
                                                  color: Colors.teal,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Residential maintenance',
                                                    style:
                                                    TextStyle(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                        0, 4, 0, 0),
                                                    child: Text(
                                                      'Spent',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '\$2000.00',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                      0, 4, 0, 0),
                                                  child: Text(
                                                    'Spent on ${DateFormat('MM-dd-yy').format(DateTime.now())}',
                                                    textAlign: TextAlign.end,
                                                    style:
                                                    TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.92,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                          child: Card(
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            color: Color(0x6639D2C0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(40),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  8, 8, 8, 8),
                                              child: Icon(
                                                Icons.monetization_on_rounded,
                                                color: Colors.teal,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                12, 0, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'New security cameras',
                                                  style:
                                                  TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                      0, 4, 0, 0),
                                                  child: Text(
                                                    'Spent',
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              12, 0, 12, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '\$30000.00',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    0, 4, 0, 0),
                                                child: Text(
                                                  'Spent on ${DateFormat('MM-dd-yy').format(DateTime.now())}',
                                                  textAlign: TextAlign.end,
                                                  style:
                                                  TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ),
                widget.loginInfo?.data['roId'] == 1? Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
                  child: FloatingActionButton(
                    child: Icon(MdiIcons.plus),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Input the new amount'),
                            content: TextField(),
                            actions: [
                              TextButton(
                                child: Text('Ok'),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                    },
                  ),
                ) :
                Container(child: SizedBox(width: 1, height: 1,)),
              ],
            )]
          ),
        )
    );
  }
}

/*

 */


//ElevatedButton(
//  onPressed: () async {
//    ,
//  child: Text("Test")
//)