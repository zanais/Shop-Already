// ignore: import_of_legacy_library_into_null_safe
//import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shopalready/renuevo.dart';

// ignore: must_be_immutable
class Recuperar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Recuperarlo();
}

class _Recuperarlo extends State<Recuperar> {
  final formKey = new GlobalKey<FormState>();
  late String _email;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Renuevo()),
      );
      return true;
    }
    return false;
  }

  void resetPassword() async {
    // ignore: unused_local_variable
    if (validateAndSave()) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
    }
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      /*validator: (value) =>
          EmailValidator.validate(value) ? null : "Ingrese un correo valido",*/
      onSaved: (value) => _email = value!,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final recuperarButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.teal[100],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          resetPassword();
        },
        child: Text(
          'Aceptar',
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.black,
          ),
        ),
      ),
    );
    return Material(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            color: Colors.white,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Recuperar contraseña',
                    style: style.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 35.0),
                  ),
                  SizedBox(height: 35.0),
                  email,
                  SizedBox(height: 20.0),
                  recuperarButon,
                ],
              ),
            )));
  }
}
