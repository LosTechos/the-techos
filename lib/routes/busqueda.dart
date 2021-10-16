import 'package:flutter/material.dart';

class Busqueda extends SearchDelegate{
  List recientes;
  List listaBusqueda;

  Busqueda({
    this.recientes = const [],
    @required this.listaBusqueda
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        this.close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        width: 100.0,
        height: 100.0,
        child: Card(
          color: Colors.blueAccent,
          child: Center(
            child: Text(query),
          )
        )
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final sugerencias = query.isEmpty ? recientes
        : listaBusqueda.where((input) => input.toUpperCase().startsWith(query.toUpperCase())).toList();
    return ListView.builder(
        itemCount: sugerencias.length,
        itemBuilder: (context, index) => ListTile(
          onTap: (){
            query = sugerencias[index];
            showResults(context);

            if(!recientes.contains(query))
              recientes.insert(0,query);
          },
          title: RichText(
              text: TextSpan(
                  text: sugerencias[index].substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold
                  ),
                  children: [
                    TextSpan(
                        text: sugerencias[index].substring(query.length),
                        style: TextStyle(color: Colors.grey)
                    )
                  ]
              )
          ),
        )
    );
  }
}