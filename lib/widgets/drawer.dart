import 'package:flutter/material.dart';
import 'package:pantallas/routes/login.dart';

class DrawerApp extends StatelessWidget {
  final String? name;

  DrawerApp({
    this.name
  });

  @override
  Widget build(BuildContext context) {
   return Drawer(
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
                   backgroundImage: AssetImage('assets/images/Shampoo-Shop.png'),
                 ),
                 SizedBox(
                     width: 15
                 ),
                 Text("$name",
                   style: TextStyle(color: Colors.white),
                 )
               ]
           ),
         ),
         ListTile(
           leading: Icon(Icons.exit_to_app_outlined),
           title: Text("Log out"),
           onTap: () {
             Navigator.of(context).pushReplacement(MaterialPageRoute(
                 builder: (context) => LoginTechos())
             );
           },
         ),
       ],
     ),
   );
  }

}