import 'package:flutter/material.dart';
import 'package:shopalready/login.dart';
import 'package:shopalready/prueba.dart';
import 'login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TiposDeUsuarios extends StatefulWidget {
  @override
  _TiposDeUsuariosState createState() => _TiposDeUsuariosState();
}

class _TiposDeUsuariosState extends State<TiposDeUsuarios> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  int number = 0;

  @override
  Widget build(BuildContext context) {
    final clienteButon = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.teal[100],
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            number = 1;
            // print(number);
            Navigator.pushNamed(context, Login.routeName, arguments: number);
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Login()));
          },
          child: Text(
            AppLocalizations.of(context)!.cliente,
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.black,
            ),
          ),
        ));

    final vendedorButon = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.teal[100],
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            number = 2;
            // print(number);
            Navigator.pushNamed(context, Login.routeName, arguments: number);
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Login()));
          },
          child: Text(
            AppLocalizations.of(context)!.vendedor,
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.black,
            ),
          ),
        ));
    Size size = MediaQuery.of(context).size;
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
            body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/shopalready.png',
                    height: size.height * 0.2,
                  ),
                  Text(
                    'ShopAlready',
                    style: style.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              clienteButon,
              SizedBox(height: 30.0),
              vendedorButon,
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
            ],
          ),
        )));
  }
}
