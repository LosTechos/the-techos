import 'package:flutter/material.dart';
import 'package:pantallas/routes/login.dart';

class DrawerApp extends StatelessWidget {
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
                   backgroundImage: AssetImage('images/Shampoo-Shop.png'),
                 ),
                 SizedBox(
                     width: 15
                 ),
                 Text("xxxxxxxdxd",
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