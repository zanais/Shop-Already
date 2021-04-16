//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:shopalready/product.dart';
//import 'package:shopalready/product.dart';
//import 'package:shopalready/main.dart';
import 'package:shopalready/productos.dart';
import 'package:shopalready/prueba.dart';
import 'package:shopalready/recuperar.dart';
import 'package:shopalready/registro.dart';
//import 'package:shopalready/tipos_usuarios.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  late String _email;
  late String _password;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Productos()),
      );
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        // ignore: unused_local_variable
        final UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      validator: (value) => (value) != null ? null : "Ingrese un correo valido",
      onSaved: (value) => _email = value!,
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email, color: Colors.black),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: AppLocalizations.of(context)!.email,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ingresar contraseña';
        }
        return null;
      },
      onSaved: (value) => _password = value!,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: AppLocalizations.of(context)!.contrasena,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.teal[100],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          validateAndSubmit();
        },
        child: Text(
          AppLocalizations.of(context)!.iniSe,
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.black,
          ),
        ),
      ),
    );
    var nom = '';
    if (number == 1) {
      nom = 'Cliente';
    } else {
      nom = 'Vendedor';
    }
    Size size = MediaQuery.of(context).size;
    return Material(
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Form(
                key: formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/shopalready.png',
                        height: size.height * 0.2,
                      ),
                      Text(
                        'Bienvenido $nom',
                        style: style.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 30.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 45.0),
                  email,
                  SizedBox(height: 20.0),
                  password,
                  SizedBox(height: 20.0),
                  GestureDetector(
                    child: Text(AppLocalizations.of(context)!.olviContra),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Recuperar()));
                    },
                  ),
                  SizedBox(height: 20.0),
                  loginButon,
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(AppLocalizations.of(context)!.noTienes),
                      GestureDetector(
                        child: Text(AppLocalizations.of(context)!.registrate,
                            style: style.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Registro()));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  IconButton(
                    icon: const Icon(Icons.language),
                    onPressed: () {
                      //MyApp.cambiarIdioma(context, Locale('en', ''));
                      //Navigator.push(context,
                      //  MaterialPageRoute(builder: (context) => Prueba()));
                      showDialog(
                        context: context,
                        builder: (_) => Prueba(),
                      );
                    },
                  ),
                  //Prueba(radioValue: _radioValue),
                ]))));
  }
}
