import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Registrado extends StatefulWidget {
  static const routeName = "registrado";
  @override
  _RegistradoState createState() => _RegistradoState();
}

class _RegistradoState extends State<Registrado> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  @override
  Widget build(BuildContext context) {
    final aceptar = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.teal[100],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        child: Text(
          AppLocalizations.of(context)!.aceptar,
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.black,
          ),
        ),
      ),
    );
    return Material(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.graciaspor,
                style: style.copyWith(
                  fontSize: 25.0,
                ),
              ),
              SizedBox(height: 50.0),
              aceptar,
            ],
          ),
        ));
  }
}
