import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:pantallas/routes/main_page.dart';

class LoginTechos extends StatelessWidget {
  late final Response? token;
  late final Response? loginInfo;
  final Duration time = Duration(milliseconds: 2600);


  Future<String?> _onLogin(LoginData login) async {
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
        'https://los-techos.herokuapp.com/api/user/${token!.data['id'] ?? 71}',
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'access-token': token!.data['token'],
          }
        )
      );
      return null;
    } on DioError catch (e) {
      if (e.response!.statusCode == 503){
        return 'MAL';
      }
      throw Exception(e);
    }
  }

  Future<String?> _onRecoverPassword(String password){
    return Future.delayed(time).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      hideSignUpButton: true,
      onLogin: _onLogin,
      passwordValidator: (data) {
        if (data!.isEmpty){
          return 'Wrong input';
        }
        return null;
      },
      userValidator: (data) {
        if (data!.isEmpty){
          return 'Wrong input';
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
      logo: 'assets/images/techos.png',
      onRecoverPassword: _onRecoverPassword,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainPage(token: token, loginInfo: loginInfo)
        ));
      },
      onSignup: (LoginData) {  },
    );
  }
  
}