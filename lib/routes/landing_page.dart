import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  _StateLandingPage createState() => _StateLandingPage();
}

class _StateLandingPage extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 2,
                children: [
                  TextButton(
                    child: Card(
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          "Expenses History",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            content: Container(
                              width: MediaQuery.of(context).size.width * .7,
                              child: GridView.count(
                                crossAxisCount: 1,
                                childAspectRatio: 4,
                                padding: const EdgeInsets.all(4),
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                                children: List.generate(30, (index) {
                                  return SizedBox(
                                    child: Card(
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(
                                          "Expense $index",
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              )
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  TextButton(
                    child: Card(
                      color: Colors.redAccent,
                      child: Center(
                        child: Text(
                          "Alerts",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 1,
                childAspectRatio: 4.8,
                children: [
                  Card(
                    child: ListTile(
                      isThreeLine: true,
                      leading: Icon(Icons.warning_rounded),
                      title: Text("Aviso de admin asies"),
                      subtitle: Row(
                        children: [
                          TextButton(
                            child: Text("XD"),
                            onPressed: () {},
                          )
                        ],
                      ),
                    )
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}