import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:pantallas/routes/main_page.dart';

class LoginTechos extends StatelessWidget {
  Response token;
  Response loginInfo;
  final Duration time = Duration(milliseconds: 2600);

  Future<String> _onSignup(LoginData signup){
    return Future.delayed(time).then((_) {
      return null;
    });
  }

  Future<String> _onLogin(LoginData login) async {
    try{
      token = await Dio().post(
        'https://los-techos.herokuapp.com/api/login',
        data: {
          "uName": login.name,
          "uPwdHash": login.password
        },
        options: Options(
          contentType: Headers.jsonContentType,
        )
      );

      loginInfo = await Dio().get(
        'https://los-techos.herokuapp.com/api/user/${token.data['id']}',
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'access-token': token.data['token'],
          }
        )
      );

      print(token.data);
      print(loginInfo.data);
      return null;
    } on DioError catch (e) {
      if (e.response.statusCode == 503){
        return 'MAL';
      }
      throw Exception(e);
    }
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
      userValidator: (data) {
        if (data.isEmpty){
          return 'MAL';
        }
        return null;
      },
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
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainPage(token: token, loginInfo: loginInfo)
        ));
      },
    );
  }
  
}