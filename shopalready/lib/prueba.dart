import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopalready/main.dart';

class Prueba extends StatefulWidget {
  @override
  _PruebaState createState() => _PruebaState();
}

enum Numeros { uno, dos }

class _PruebaState extends State<Prueba> {
  //int radioValue = 0;

  Numeros? number = Numeros.uno;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Idioma'),
      children: <Widget>[
        Text(AppLocalizations.of(context)!.helloWorld),
        ListTile(
          title: const Text('Español'),
          leading: Radio(
            value: Numeros.uno,
            groupValue: number,
            onChanged: (Numeros? value) {
              MyApp.cambiarIdioma(context, Locale('es', ''));
              number = value;
            },
          ),
        ),
        ListTile(
          title: const Text('English'),
          leading: Radio(
            value: Numeros.dos,
            groupValue: number,
            onChanged: (Numeros? value) {
              MyApp.cambiarIdioma(context, Locale('en', ''));
              number = value;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Aceptar"))
            ],
          ),
        ),
      ],
    );
  }
}
