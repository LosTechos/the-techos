import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:pantallas/data/fake_data.dart';
import 'package:pantallas/routes/main_page.dart';

class LoginBarber extends StatelessWidget {
  final Duration time = Duration(milliseconds: 2600);

  Future<String> _onSignup(LoginData signup){
    return Future.delayed(time).then((_) {
      return null;
    });
  }

  Future<String> _onLogin(LoginData login){
    return Future.delayed(time).then((_) {
      if(!user['usuario'].contains(login.name)){
        return 'error de usuario';
      }
      if(!user['password'].contains(login.password)){
        return 'error de contraseña';
      }
      return null;
    });
  }

  Future<String> _onRecoverPassword(String password){
    return Future.delayed(time).then((_) {

      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      hideSignUpButton: true,
      onSignup: _onSignup,
      onLogin: _onLogin,
      theme: LoginTheme(
        primaryColor: Colors.white,
        buttonTheme: LoginButtonTheme(
          backgroundColor: Colors.green
        )
      ),
      navigateBackAfterRecovery: true,
      logo: 'images/techos.png',
      onRecoverPassword: _onRecoverPassword,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage()));
      },
    );
  }
  
}