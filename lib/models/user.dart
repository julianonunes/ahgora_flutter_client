import 'dart:io';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class User {
  final tokenKey = 'token_key';
  final loginKey = 'login_key';
  final passwordKey = 'password_key';

  String identity;
  String account;
  String password;

  read() async {
    final prefs = await SharedPreferences.getInstance();
    identity = prefs.getString(tokenKey);
    account = prefs.getString(loginKey);
    password = prefs.getString(passwordKey);
  }

  Future<http.Response> register() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(tokenKey, identity);
    prefs.setString(loginKey, account);
    prefs.setString(passwordKey, password);
    
    final response = await http.post('https://www.ahgora.com.br/batidaonline/verifyIdentification',
      headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader : ''
        },
        body: json.encode({
          identity: this.identity,
          account: this.account,
          password: this.password,
          'origin': 'pw2',
          'key': ''
        })
      );

    return response;
  }
}