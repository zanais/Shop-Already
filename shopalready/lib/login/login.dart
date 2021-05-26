import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shopalready/providers/auth.dart';
import '../http_exceptions.dart';
import '../screens/cliente/productos.dart';
import 'package:shopalready/login/recuperar.dart';
import 'package:shopalready/login/registro.dart';
import '../widgets/prueba.dart';
import '../screens/vendedor/vendedor_productos.dart';

class Login extends StatefulWidget {
  static const routeName = "login";
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

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

  Future<void> _submit(int userType) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      await Provider.of<Auth>(context, listen: false).login(
        _authData['email']!,
        _authData['password']!,
      );
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
    if (userType == 1) {
      Navigator.pushReplacementNamed(context, Productos.routeName);
    } else {
      Navigator.pushReplacementNamed(context, VendedorProductos.routeName);
    }
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  @override
  Widget build(BuildContext context) {
    int userType = ModalRoute.of(context)!.settings.arguments as int;

    final email = TextFormField(
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Invalid email';
        }
      },
      onSaved: (value) {
        _authData['email'] = value!;
      },
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
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
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
        onPressed: () async {
          await _submit(userType);
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
    if (userType == 1) {
      nom = AppLocalizations.of(context)!.cliente;
    } else {
      nom = AppLocalizations.of(context)!.vendedor;
    }

    //Size size = MediaQuery.of(context).size;
    return Material(
        child: Container(
            color: userType == 1 ? Colors.white : Colors.red[200],
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 60.0),
                  Text(
                    //'Bienvenido $nom',
                    AppLocalizations.of(context)!.bienvenido + ' $nom',
                    style: style.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 40.0),
                  ),
                  SizedBox(height: 45.0),
                  email,
                  SizedBox(height: 20.0),
                  password,
                  SizedBox(height: 20.0),
                  GestureDetector(
                    child: Text(AppLocalizations.of(context)!.olviContra),
                    onTap: () {
                      Navigator.pushNamed(context, Recuperar.routeName);
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
                          Navigator.pushReplacementNamed(
                              context, Registro.routeName,
                              arguments: userType);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  IconButton(
                    icon: const Icon(Icons.language),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => Prueba(),
                      );
                    },
                  ),
                ]))));
  }
}
