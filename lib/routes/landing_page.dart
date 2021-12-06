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
                            onPressed: () {

                            },
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