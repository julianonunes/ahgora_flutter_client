import 'dart:io';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class User {
  static final tokenKey = 'token_key';
  static final loginKey = 'login_key';
  static final passwordKey = 'password_key';

  String identity;
  String account;
  String password;

  Future<http.Response> register() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(tokenKey, identity);
    prefs.setString(loginKey, account);
    prefs.setString(passwordKey, password);
    
    final response = await http.post('https://www.ahgora.com.br/batidaonline/verifyIdentification',
      headers: {
          HttpHeaders.contentTypeHeader: 'multipart/form-data'
        },
        body: json.encode({
          'identity': this.identity,
          'account': this.account,
          'password': this.password,
          'origin': 'pw2'
        })
      );

    return response;
  }
}