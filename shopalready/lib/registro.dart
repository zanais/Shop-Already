import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopalready/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shopalready/registrado.dart';

// ignore: must_be_immutable
class Registro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegistroPage();
}

class _RegistroPage extends State<Registro> {
  final formKey = new GlobalKey<FormState>();
  var confirmPass;
  String _email;
  String _password;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Registrado()),
      );
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      // ignore: unused_local_variable
      final UserCredential user = await FirebaseAuth.instance
          // ignore: missing_return
          .createUserWithEmailAndPassword(email: _email, password: _password)
          // ignore: missing_return
          .then((user) {
        try {
          FirebaseAuth.instance.currentUser.sendEmailVerification();
          //Navigator.pop(context);
          return user;
        } catch (e) {
          print(e);
        }
      });
    }
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    final email = TextFormField(
      validator: (value) =>
          EmailValidator.validate(value) ? null : "Ingrese un correo valido",
      onSaved: (value) => _email = value,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = TextFormField(
      validator: (String value) {
        confirmPass = value;
        if (value.isEmpty) {
          return 'Ingresar contraseña';
        }
        return null;
      },
      onSaved: (value) => _password = value,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Contraseña',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password2 = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingresar contraseña';
        }
        if (value != confirmPass) {
          return 'Las contraseñas no coinciden';
        }
        return null;
      },
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Confirmar Contraseña',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final registroButon = Material(
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
          'Registrate',
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.black,
          ),
        ),
      ),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
            key: formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 35.0),
                  Text('Registrate',
                      style: style.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0)),
                  SizedBox(height: 70.0),
                  email,
                  SizedBox(height: 20.0),
                  password,
                  SizedBox(height: 20.0),
                  password2,
                  SizedBox(height: 20.0),
                  registroButon,
                  SizedBox(height: 40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '¿Ya tienes cuenta?',
                        style: style.copyWith(
                          fontSize: 15.0,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          'Inicia Sesión',
                          style: style.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                      ),
                    ],
                  )
                ]),
          ),
        )));
  }
}