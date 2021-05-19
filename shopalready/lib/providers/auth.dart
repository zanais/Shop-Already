import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../http_exceptions.dart';

class Auth with ChangeNotifier {
  late String _token;
  late String _emailId;
  late String _userId;

  String get token {
    if (_token != null) {
      return _token;
    }
    return 'null';
  }

  String get userId {
    return _userId;
  }

  String get emailId {
    return _emailId;
  }

  Future<void> singup(String nombre, String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCpDpJauBP4W4GF8yvqLNoxH-WUUGCBtzs');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'nombre': nombre,
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCpDpJauBP4W4GF8yvqLNoxH-WUUGCBtzs');
    try {
      final comprobar = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final comprobarData = json.decode(comprobar.body);
      if (comprobarData['error'] != null) {
        throw HttpException(comprobarData['error']['message']);
      }
      _token = comprobarData['idToken'];
      _userId = comprobarData['localId'];
      _emailId = comprobarData['email'];

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
