//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shopalready/http_exceptions.dart';
import 'package:shopalready/login/registrado.dart';
import 'package:shopalready/providers/auth.dart';
import 'package:shopalready/widgets/prueba.dart';

class Registro extends StatefulWidget {
  static const routeName = "registro";
  @override
  State<StatefulWidget> createState() => _RegistroPage();
}

class _RegistroPage extends State<Registro> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'nombre': '',
    'email': '',
    'password': '',
  };
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Ocurrió un error'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      await Provider.of<Auth>(context, listen: false).singup(
        _authData['nombre']!,
        _authData['email']!,
        _authData['password']!,
      );
      Navigator.pushReplacementNamed(context, Registrado.routeName);
    } on HttpException catch (error) {
      var errorMessage = 'Autenticación falló';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'La cuenta actualmente existe';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'El email no es valido';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Contraseña muy débil';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'No se pudo encontrar a un usuario con ese email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Contraseña invalida';
      }
      _showErrorDialog(errorMessage);
    } catch (eror) {
      const errorMessage = 'No se pudo autenticar. Intente más tarde';
      _showErrorDialog(errorMessage);
    }
    _formKey.currentState!.save();
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  @override
  Widget build(BuildContext context) {
    int userType = ModalRoute.of(context)!.settings.arguments as int;
    //Size size = MediaQuery.of(context).size;
    final email = TextFormField(
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Invalid email';
        }
      },
      onSaved: (value) {
        _authData['email'] = value!;
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: AppLocalizations.of(context)!.email,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = TextFormField(
      validator: (value) {
        if (value!.isEmpty || value.length < 5) {
          return 'Contraseña muy corta';
        }
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
      controller: _passwordController,
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
    final password2 = TextFormField(
      validator: (value) {
        if (value != _passwordController.text) {
          return 'No coinciden';
        }
      },
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: AppLocalizations.of(context)!.confirmar,
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
          _submit();
        },
        child: Text(
          AppLocalizations.of(context)!.registrate,
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.black,
          ),
        ),
      ),
    );
    final nombreButon = TextFormField(
      //validator: (value) {},
      onSaved: (value) {
        _authData['nombre'] = value!;
      },
      //obscureText: true,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.contacts,
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: AppLocalizations.of(context)!.nombre,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    var nom = '';
    if (userType == 1) {
      nom = AppLocalizations.of(context)!.cliente;
    } else {
      nom = AppLocalizations.of(context)!.vendedor;
    }
    return Material(
        child: Container(
      color: userType == 1 ? Colors.white : Colors.red[200],
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Form(
        key: _formKey,
        child: InkWell(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 35.0),
                Text(AppLocalizations.of(context)!.registrate + ', $nom',
                    style: style.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0)),
                SizedBox(height: 30.0),
                nombreButon,
                SizedBox(
                  height: 20.0,
                ),
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
                      AppLocalizations.of(context)!.yatienes,
                      style: style.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        AppLocalizations.of(context)!.iniSe,
                        style: style.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                    ),
                  ],
                ),
              ]),
        ),
      ),
    ));
  }
}
