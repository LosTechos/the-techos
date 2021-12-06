import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LandingPage extends StatefulWidget {
  _StateLandingPage createState() => _StateLandingPage();
}

class _StateLandingPage extends State<LandingPage> {
  List<String> imgText = [
    "Are you getting married?",
    "University loans",
    "Vacation Villas",
    "Travels",

  ];

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    ];
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      '${imgText[imgList.indexOf(item)]}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    )).toList();

    return ListView(
      shrinkWrap: true,
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 2,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Text('Ask your landlord for the following services:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              CarouselSlider(
                  items: imageSliders,
                  options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.3,
                      enlargeCenterPage: true
                  )
              ),
              Card(
                  child: ListTile(
                    isThreeLine: false,
                    leading: CircleAvatar(
                      backgroundColor: Colors.yellow,
                      child: Icon(MdiIcons.alert, color: Colors.black,size: 30,),
                    ),
                    title: Text("There have been expenses in the budget"),
                  )
              ),
              Card(
                  child: ListTile(
                    isThreeLine: false,
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(MdiIcons.alert, color: Colors.black,size: 30,),
                    ),
                    title: Text("You have pending payments"),
                  )
              ),

            ],
          ),
        ),
      ],
    );
  }
}