import 'package:flutter/material.dart';
import 'package:shopalready/login.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static void cambiarIdioma(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setState(() {
      state.myLocale = newLocale;
    });
  }

  static void setLocale(BuildContext context, Locale locale) {}
}

class _MyAppState extends State<MyApp> {
  Locale myLocale = Locale('es', '');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: myLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Shop Already',
      home: Login(),
    );
  }
}
