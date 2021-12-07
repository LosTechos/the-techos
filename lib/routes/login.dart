import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:pantallas/routes/main_page.dart';

class LoginTechos extends StatefulWidget {
  @override
  _StateLoginTechos createState() => _StateLoginTechos();
}

class _StateLoginTechos extends State<LoginTechos> {
  late Response loginInfo;
  late Response userInfo;
  final Duration time = Duration(milliseconds: 2600);


  Future<String?> _onLogin(LoginData login) async {
    try{
      var resL = await Dio().post(
        'https://los-techos.herokuapp.com/api/login',
        data: {
          "uName": login.name,
          "uPwdHash": login.password
        },
        options: Options(
          contentType: Headers.jsonContentType,
        )
      );
      loginInfo = resL;

      var res = await Dio().get(
        'https://los-techos.herokuapp.com/api/user/${loginInfo.data['id'] ?? 71}',
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'access-token': loginInfo.data['token'],
          }
        )
      );
      userInfo = res;
      return null;
    } on DioError catch (e) {
      if (e.response!.statusCode == 503){
        return 'MAL';
      }
      throw Exception(e);
    }
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
      onRecoverPassword: (ded){},
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return MainPage(loginInfo: loginInfo, userInfo: userInfo);
          }
        ));
      },
      onSignup: (loginData) {  },
    );
  }
  
}