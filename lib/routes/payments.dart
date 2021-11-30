import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Payments extends StatefulWidget {
  const Payments({Key key}) : super(key: key);

  _StatePayments createState() => _StatePayments();
}

class _StatePayments extends State<Payments> {
  bool noDebt = false;
  double cardHeight = 310;
  Color backgroundColor = Color.fromRGBO(37, 40, 80, 1.0);
  Color buttonColor = Colors.red;
  Color iconColor = Colors.red;
  IconData warning = Icons.warning_rounded;
  IconData done = Icons.check_circle_sharp;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset.infinite
                    )
                  ]
                ),
                child: const Text(
                  'Debts',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    color: Colors.white
                  ),
                ),
              ),
              SizedBox(
                height: cardHeight,
                width: MediaQuery.of(context).size.width - 25,
                child: Card(
                  color: backgroundColor,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(40),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Icon(Icons.access_time_outlined, size: 50, color: iconColor,),
                        SizedBox(
                            height: 5.0
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Text(
                            (noDebt? 'You have no pending payments' : 'Late Payment: 3000 mxn. Last payment date November 7 2021'),
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              height: 3,
                              color: Colors.white
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: noDebt? 0 : 30,
                        ),
                        noDebt? SizedBox(width: 1,) : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              noDebt = true;
                              backgroundColor = Colors.lightGreen;
                              cardHeight = 151;
                              iconColor = Colors.white;
                            });
                          },
                          child: const Text("Pay now"),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(buttonColor)
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      DatePicker.showTime12hPicker(context,
                        onChanged: (date) {
                          print(date);
                        }
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ]
    );
  }
}
